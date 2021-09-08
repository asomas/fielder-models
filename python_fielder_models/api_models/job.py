from python_fielder_models.api_models.common import GooglePlaceDataSerializer
from python_fielder_models.api_models.organisation import \
    OrganisationLocationAPISerializer
from python_fielder_models.db_models.common import RecurrenceSerializer
from rest_framework import serializers


class ApproveShiftRequestSerializer(serializers.Serializer):
    shift_date = serializers.DateField(
        format="%Y-%m-%d", input_formats=["%Y-%m-%d"], required=False, allow_null=True
    )


class UnAssignWorkerfromShiftPatternRequestSerializer(serializers.Serializer):
    worker_id = serializers.CharField()
    shift_date = serializers.DateField(format="%Y-%m-%d", input_formats=["%Y-%m-%d"])
    range = serializers.ChoiceField(("current", "future", "all"))


class DeleteShiftPatternRequestSerializer(serializers.Serializer):
    shift_date = serializers.DateField(format="%Y-%m-%d", input_formats=["%Y-%m-%d"])
    range = serializers.ChoiceField(("current", "future", "all"))


class ShiftPatternAPISerializer(serializers.Serializer):
    start_date = serializers.DateField()
    end_date = serializers.DateField(required=False)
    start_time = serializers.IntegerField()
    end_time = serializers.IntegerField()
    recurrence = RecurrenceSerializer()
    geo_fence_enabled = serializers.BooleanField()
    geo_fence_distance = serializers.IntegerField(
        required=False, max_value=3000, min_value=15
    )
    existing_location_id = serializers.CharField(required=False)
    new_location_data = OrganisationLocationAPISerializer(required=False)
    google_place_data = GooglePlaceDataSerializer(required=False)

    def validate(self, data):
        # this validation will run after RecurrenceSerializer's validation
        if data["geo_fence_enabled"] == True and "geo_fence_distance" not in data:
            raise serializers.ValidationError(
                detail={
                    "geo_fence_distance": [
                        "This field is required when geo_fence_enabled is true."
                    ]
                }
            )

        # so in case of non-recurring, the repeat_interval_type = "None" should have been converted
        # to repeat_interval_type = None
        if (
            data["recurrence"]["repeat_interval_type"] is not None
            and "end_date" not in data
        ):
            raise serializers.ValidationError(
                "recurring shift should have an end_date."
            )
        if data["recurrence"]["repeat_interval_type"] is None:
            if "end_date" in data:
                raise serializers.ValidationError(
                    "Non-recurring shift should have no end date. "
                )
            else:
                data["end_date"] = data["start_date"]
        if data["start_date"] > data["end_date"]:
            raise serializers.ValidationError("start_date must be before end_date")
        if data["start_time"] > data["end_time"]:
            raise serializers.ValidationError("start_time must be before end_time")

        # check if one and only one from ["google_place_data", "new_location_data", "existing_location_id"] exist in data dict
        if (
            sum(
                [
                    "google_place_data" in data,
                    "new_location_data" in data,
                    "existing_location_id" in data,
                ]
            )
            != 1
        ):
            raise serializers.ValidationError(
                "One and only one of google_place_data, new_location_data, existing_location_id must be provided"
            )

        return data


class AddShiftPatternRequestSerializer(serializers.Serializer):
    job_id = serializers.CharField()
    shift_pattern_data = ShiftPatternAPISerializer()

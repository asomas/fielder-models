from math import ceil, floor

from fielder_backend_utils.rest_utils import CleanHTMLField, DocumentReferenceField
from python_fielder_models.api_models.common import GooglePlaceDataSerializer
from python_fielder_models.api_models.organisation import (
    OrganisationLocationAPISerializer,
)
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


class PaymentAPISerializer(serializers.Serializer):

    pension_contribution_percentage = 0.03
    apprentice_levy_percentage = 0.005
    ni_contribution_percentage = 0.138
    holiday_pay_percentage = 0.1207
    umbrella_fee_percentage = 0.03
    finders_fee_precentage = 0.03
    sick_leave_percentage = 0.0

    def to_internal_value(self, data):
        data = super().to_internal_value(data)
        data["total_umbrella_service_cost"] = ceil(
            data["total_staffing_service_cost"] / 1.06 * 1.03
        )
        data["total_cost_excl_fees"] = data["total_staffing_service_cost"] / 1.06
        data["umbrella_fee"] = ceil(
            PaymentAPISerializer.umbrella_fee_percentage * data["total_cost_excl_fees"]
        )
        data["finders_fee"] = ceil(
            PaymentAPISerializer.finders_fee_precentage * data["total_cost_excl_fees"]
        )

        statutary_costs = {}
        statutary_costs["ni_contribution"] = data["total_cost_excl_fees"] - (
            data["total_cost_excl_fees"]
            / (1 + PaymentAPISerializer.ni_contribution_percentage)
        )
        statutary_costs["pension_contribution"] = data["total_cost_excl_fees"] - (
            data["total_cost_excl_fees"]
            / (1 + PaymentAPISerializer.pension_contribution_percentage)
        )
        statutary_costs["apprentice_levy"] = data["total_cost_excl_fees"] - (
            data["total_cost_excl_fees"]
            / (1 + PaymentAPISerializer.apprentice_levy_percentage)
        )
        statutary_costs["sick_leave"] = 0
        statutary_costs["total"] = (
            statutary_costs["ni_contribution"]
            + statutary_costs["pension_contribution"]
            + statutary_costs["apprentice_levy"]
            + statutary_costs["sick_leave"]
        )
        data["statutary_costs"] = statutary_costs

        combined_worker_rate_and_holiday = floor(
            data["total_cost_excl_fees"] - statutary_costs["total"]
        )
        data["worker_rate"] = floor(
            combined_worker_rate_and_holiday
            / (1 + PaymentAPISerializer.holiday_pay_percentage)
        )
        data["holiday_pay"] = combined_worker_rate_and_holiday - data["worker_rate"]

        return super().to_internal_value(data)

    class StatutaryCostsSerializer(serializers.Serializer):
        total = serializers.FloatField(required=False)
        ni_contribution = serializers.FloatField(required=False)
        pension_contribution = serializers.FloatField(required=False)
        apprentice_levy = serializers.FloatField(required=False)
        sick_leave = serializers.FloatField(required=False)

    worker_rate = serializers.IntegerField(required=False)
    holiday_pay = serializers.IntegerField(required=False)
    statutary_costs = StatutaryCostsSerializer(required=False)
    total_cost_excl_fees = serializers.FloatField(required=False)
    umbrella_fee = serializers.FloatField(required=False)
    finders_fee = serializers.FloatField(required=False)
    total_umbrella_service_cost = serializers.IntegerField(required=False)
    total_staffing_service_cost = serializers.IntegerField()


class ShiftBudgetBaseSerializer(serializers.Serializer):
    volunteer = serializers.BooleanField(default=False)
    payment = PaymentAPISerializer()
    pay_calculation = serializers.ChoiceField(
        (
            "Actual hours",
            "Shift hours",
        ),
        default="Actual hours",
    )
    enable_late_deduction = serializers.BooleanField(default=False)
    late_arrival = serializers.ChoiceField((0, 15, 30, 60), default=15)
    enable_early_deduction = serializers.BooleanField(default=False)
    early_leaver = serializers.ChoiceField((0, 15, 30, 60), default=15)
    overtime_rate = serializers.IntegerField(default=0)
    overtime_threshold = serializers.ChoiceField((0, 15, 30, 60), default=15)
    enable_unpaid_breaks = serializers.BooleanField(default=False)

    # serializer validation order https://stackoverflow.com/a/60161014/1608420
    def validate(self, data):
        if "payment" in data and "total_staffing_service_cost" in data["payment"]:
            if data["payment"]["total_staffing_service_cost"] > 0 and data.get(
                "volunteer", False
            ):
                raise serializers.ValidationError(
                    "Volunteering shifts cannot have rates"
                )
            elif data["payment"]["total_staffing_service_cost"] <= 0 and not data.get(
                "volunteer", False
            ):
                raise serializers.ValidationError(
                    "Budget should either have rates or be a volunteering shift"
                )

        if data.get("pay_calculation") == "Actual hours":
            if data.get("enable_late_deduction") or data.get("enable_early_deduction"):
                raise serializers.ValidationError(
                    "Cannot enable late or early deduction when pay calculation is Actual hours!"
                )

        return data


class ShiftBudgetAPISerializer(ShiftBudgetBaseSerializer):
    budget_ref = DocumentReferenceField(allow_null=True, default=None)


class ShiftPatternAPISerializer(serializers.Serializer):
    start_date = serializers.DateField()
    end_date = serializers.DateField(required=False)
    start_time = serializers.IntegerField(min_value=0, max_value=86400)
    end_time = serializers.IntegerField(min_value=0, max_value=172800)
    multi_day_shift = serializers.BooleanField(default=False)
    recurrence = RecurrenceSerializer()
    geo_fence_enabled = serializers.BooleanField(default=False)
    geo_fence_distance = serializers.IntegerField(
        required=False, max_value=3000, min_value=15
    )
    existing_location_id = serializers.CharField(required=False)
    new_location_data = OrganisationLocationAPISerializer(required=False)
    google_place_data = GooglePlaceDataSerializer(required=False)
    shift_note_value = CleanHTMLField(
        required=False,
        default=None,
        allow_null=True,
    )
    budget = ShiftBudgetAPISerializer(required=False)

    def to_internal_value(self, data):
        if "end_time" in data and data["end_time"] > 86400:
            data["multi_day_shift"] = True

        return super().to_internal_value(data)

    def validate(self, data):
        # this validation will run after RecurrenceSerializer's validation
        if (
            data.get("geo_fence_enabled", False) == True
            and "geo_fence_distance" not in data
        ):
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


class ShiftActivityRequestSerializer(serializers.Serializer):
    needs_attention = serializers.BooleanField()


class EditShiftPatternRequestSerializer(serializers.Serializer):
    range = serializers.ChoiceField(("current", "future", "all"))
    shift_date = serializers.DateField(
        format="%Y-%m-%d", input_formats=["%Y-%m-%d"], required=False
    )
    shift_pattern_data = ShiftPatternAPISerializer()

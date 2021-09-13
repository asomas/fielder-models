from datetime import datetime
from enum import Enum

from fielder_backend_utils.rest_utils import DocumentReferenceField
from python_fielder_models.db_models.common import RecurrenceSerializer
from python_fielder_models.db_models.organisation import (
    OrganisationLocationDBSerializer,
)
from rest_framework import serializers


class OfferStatus(Enum):
    Pending = 0
    Queued = 1
    Declined = 2
    Accepted = 3
    Expired = 4


# TODO complete all other fields
class ShiftPatternDBSerializer(serializers.Serializer):
    start_date = serializers.DateField()
    end_date = serializers.DateField(required=False)
    start_time = serializers.IntegerField()
    end_time = serializers.IntegerField()
    recurrence = RecurrenceSerializer()
    location_data = OrganisationLocationDBSerializer()
    organisation_ref = DocumentReferenceField()

    def validate(self, data):
        # this validation will run after RecurrenceSerializer's validation
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

        return data


class OfferDBSerializer(serializers.Serializer):
    shift_pattern_ref = DocumentReferenceField()
    worker_ref = DocumentReferenceField()
    job_ref = DocumentReferenceField()
    shift_pattern_data = serializers.DictField()  # set as dict to pass tests
    worker_data = serializers.DictField()
    job_data = serializers.DictField()  # set as dict to pass tests
    status = serializers.ChoiceField(choices=OfferStatus._member_names_)
    expiry_time = serializers.DateTimeField(allow_null=True, default=None)
    created_at = serializers.DateTimeField(default=datetime.now())
    updated_at = serializers.DateTimeField(default=datetime.now())

    def to_internal_value(self, data):
        data["updated_at"] = datetime.now()
        return super().to_internal_value(data)

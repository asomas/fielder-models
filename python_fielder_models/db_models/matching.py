from datetime import datetime, time
from enum import Enum, auto

from fielder_backend_utils.rest_utils import DocumentReferenceField
from python_fielder_models.api_models.matching import SchedulerRequestSerializer
from python_fielder_models.db_models import BaseDBSerializer
from rest_framework import serializers


class ScheduleTaskStatus(Enum):
    NOT_STARTED = auto()
    IN_PROGRESS = auto()
    COMPLETED = auto()
    FAILED = auto()
    CANCELLED = auto()


class ScheduleTaskResultStatus(Enum):
    SUCCESS = auto()
    FAILURE = auto()


class ScheduleTaskDBSerializer(BaseDBSerializer):
    organisation_ref = DocumentReferenceField()
    organisation_user_ref = DocumentReferenceField()
    progress_percent = serializers.IntegerField(min_value=0, max_value=100, default=0)
    status = serializers.ChoiceField(
        choices=ScheduleTaskStatus._member_names_,
        default=ScheduleTaskStatus.NOT_STARTED.name,
    )
    archived = serializers.BooleanField(default=False)
    step_message = serializers.CharField(default="Queued")


class ScheduleTaskResultDBSerializer(BaseDBSerializer):
    class SchedulerAssignmentSerializer(serializers.Serializer):
        shift_pattern_ref = DocumentReferenceField()
        start_date = serializers.DateTimeField()
        end_date = serializers.DateTimeField()
        worker_ref = DocumentReferenceField()
        worker_data = serializers.DictField()

    status = serializers.ChoiceField(
        choices=ScheduleTaskResultStatus._member_names_,
        default=ScheduleTaskResultStatus.SUCCESS.name,
    )
    status_message = serializers.CharField(default="Scheduler completed successfully")
    assignments = serializers.ListField(
        child=SchedulerAssignmentSerializer(), default=[]
    )


class ScheduleTaskRequestDBSerializer(BaseDBSerializer):
    request_data = SchedulerRequestSerializer()

    def to_internal_value(self, data):
        data = super().to_internal_value(data)
        for shift in data.get("request_data", {}).get("shifts", []):
            shift["start_date"] = datetime.combine(shift["start_date"], time(0, 0))
            shift["end_date"] = datetime.combine(shift["end_date"], time(0, 0))
        return data

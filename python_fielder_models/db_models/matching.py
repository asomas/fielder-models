from datetime import datetime, time
from enum import Enum, auto

from fielder_backend_utils.rest_utils import DocumentReferenceField
from python_fielder_models.api_models.matching import SchedulerRequestSerializer
from python_fielder_models.common.job import OccupationSerializer, SkillSerializer
from python_fielder_models.db_models import BaseDBSerializer
from python_fielder_models.db_models.common import LocationDBSerializer
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


class InterestCardWorkerResponse(Enum):
    NO_RESPONSE = auto()
    POSITIVE = auto()
    NEGATIVE = auto()


class JobInterestCardDBSerialzier(BaseDBSerializer):
    class JobPostSerializer(serializers.Serializer):
        job_title = serializers.CharField()
        job_description = serializers.CharField(allow_null=True, default=None)
        job_location_raw = serializers.CharField(allow_null=True, default=None)
        job_location_parsed = LocationDBSerializer(allow_null=True, default=None)
        job_link = serializers.CharField(allow_null=True, default=None)
        organisation_name = serializers.CharField()
        contact_person = serializers.CharField(allow_null=True, default=None)
        contact_phone = serializers.CharField(allow_null=True, default=None)
        contact_email = serializers.CharField(allow_null=True, default=None)
        tk_occupation = serializers.CharField(allow_null=True, default=None)
        occupation = OccupationSerializer(allow_null=True, default=None)
        skills = serializers.ListField(
            allow_null=True, default=None, allow_empty=True, child=SkillSerializer()
        )
        advertiser_type = serializers.CharField(allow_null=True, default=None)
        job_link = serializers.CharField(allow_null=True, default=None)

    class MatchScoreSerializer(serializers.Serializer):
        skills_score = serializers.IntegerField(min_value=0, max_value=100)
        overall_score = serializers.IntegerField(min_value=0)
        distance_score = serializers.IntegerField(min_value=0, max_value=100)
        number_matched_skills = serializers.IntegerField(min_value=0)
        distance = serializers.FloatField(min_value=0)

    job_post = JobPostSerializer()
    worker_ref = DocumentReferenceField()
    worker_response = serializers.ChoiceField(
        choices=InterestCardWorkerResponse._member_names_,
        default=InterestCardWorkerResponse.NO_RESPONSE.name,
    )
    match_scores = MatchScoreSerializer()

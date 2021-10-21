from enum import Enum, auto

from python_fielder_models.api_models.common import LocationAPISerializer
from python_fielder_models.db_models.common import RecurrenceSerializer
from rest_framework import serializers


class WorkerType(Enum):
    FIELDER = auto()
    STAFF = auto()
    NETWORK = auto()


class MatchingRequestSerializer(serializers.Serializer):
    class CourseLevelSerializer(serializers.Serializer):
        course_id = serializers.CharField()
        level_id = serializers.CharField(allow_null=True, default="0")
        level_number = serializers.IntegerField(allow_null=True, default=0)

    worker_id = serializers.CharField(required=False, allow_blank=True)
    skills = serializers.ListField(
        required=False, allow_null=True, allow_empty=True, child=serializers.CharField()
    )
    courses = serializers.ListField(
        required=False, allow_null=True, allow_empty=True, child=CourseLevelSerializer()
    )
    checks = serializers.ListField(
        required=False, allow_null=True, allow_empty=True, child=serializers.CharField()
    )
    end_date = serializers.DateField()
    end_time = serializers.IntegerField(min_value=0, max_value=86400)
    recurrence = RecurrenceSerializer()
    start_date = serializers.DateField()
    start_time = serializers.IntegerField(min_value=0, max_value=86400)
    skip = serializers.IntegerField(min_value=0, default=0)
    limit = serializers.IntegerField(min_value=0, max_value=10, default=5)
    worker_type = serializers.ChoiceField(choices=WorkerType._member_names_)
    address = LocationAPISerializer()


class MatchingWorker(serializers.Serializer):
    id = serializers.CharField()
    skills_score = serializers.IntegerField(min_value=0, max_value=100)
    qualifications_score = serializers.IntegerField(min_value=0, max_value=100)
    checks_score = serializers.IntegerField(min_value=0, max_value=100)
    availability_score = serializers.IntegerField(min_value=0, max_value=100)
    overall_score = serializers.IntegerField(min_value=0, max_value=100)
    distance = serializers.FloatField(min_value=0)


class MatchingResponseSerializer(serializers.Serializer):
    workers = serializers.ListField(child=MatchingWorker(), allow_empty=True)

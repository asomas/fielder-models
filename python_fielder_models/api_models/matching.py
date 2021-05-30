from python_fielder_models.db_models.common import RecurrenceSerializer
from rest_framework import serializers


class MatchingRequestSerializer(serializers.Serializer):
    worker_id = serializers.CharField(required=False, allow_blank=True)
    skills = serializers.ListField(
        required=False, allow_null=True, child=serializers.CharField()
    )
    qualifications = serializers.ListField(
        required=False, allow_null=True, child=serializers.CharField()
    )
    checks = serializers.ListField(
        required=False, allow_null=True, child=serializers.CharField()
    )
    end_date = serializers.DateTimeField()
    end_time = serializers.IntegerField(min_value=0, max_value=86400)
    recurrence = RecurrenceSerializer()
    start_date = serializers.DateTimeField()
    start_time = serializers.IntegerField(min_value=0, max_value=86400)
    skip = serializers.IntegerField(min_value=0, max_value=10, default=0)
    limit = serializers.IntegerField(min_value=0, max_value=10, default=5)
    is_staff = serializers.BooleanField(default=False, required=False)


class MatchingWorker(serializers.Serializer):
    id = serializers.CharField()
    skills_score = serializers.IntegerField(min_value=0, max_value=100)
    qualifications_score = serializers.IntegerField(min_value=0, max_value=100)
    checks_score = serializers.IntegerField(min_value=0, max_value=100)
    availability_score = serializers.IntegerField(min_value=0, max_value=100)
    overall_score = serializers.IntegerField(min_value=0, max_value=100)


class MatchingResponseSerializer(serializers.Serializer):
    workers = serializers.ListField(child=MatchingWorker(), allow_empty=True)
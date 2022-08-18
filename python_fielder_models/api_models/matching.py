from enum import Enum, auto

from python_fielder_models.api_models.common import LocationAPISerializer
from python_fielder_models.db_models.common import RecurrenceSerializer
from rest_framework import serializers


class WorkerType(Enum):
    FIELDER = auto()
    STAFF = auto()
    NETWORK = auto()
    STAFF_FIELDER = auto()


class BaseMatchingShiftRequestSerializer(serializers.Serializer):
    start_time = serializers.IntegerField(min_value=0, max_value=86400)
    end_time = serializers.IntegerField(min_value=0, max_value=172800)
    start_date = serializers.DateField()
    end_date = serializers.DateField()
    recurrence = RecurrenceSerializer()
    multi_day_shift = serializers.BooleanField(required=False)


class AvailabilityScoreRequestSerializer(BaseMatchingShiftRequestSerializer):
    worker_id = serializers.CharField()
    organisation_id = serializers.CharField()


class MatchingShiftRequestSerializer(BaseMatchingShiftRequestSerializer):
    class CourseLevelGradeSerializer(serializers.Serializer):
        course_id = serializers.CharField()
        level_id = serializers.CharField(allow_null=True, default="0")
        level_number = serializers.IntegerField(allow_null=True, default=0)
        grade_id = serializers.CharField(allow_null=True, default="0")
        grade_number = serializers.IntegerField(allow_null=True, default=0)

    skills = serializers.ListField(
        required=False, allow_null=True, allow_empty=True, child=serializers.CharField()
    )
    courses = serializers.ListField(
        required=False,
        allow_null=True,
        allow_empty=True,
        child=CourseLevelGradeSerializer(),
    )
    checks = serializers.ListField(
        required=False, allow_null=True, allow_empty=True, child=serializers.CharField()
    )
    address = LocationAPISerializer()

    def to_internal_value(self, data):
        data = super().to_internal_value(data)
        if "courses" in data:
            courses = []
            for course in data["courses"]:
                level_id = course.get("level_id") or "0"
                level_number = course.get("level_number") or 0

                grade_id = course.get("grade_id") or "0"
                grade_number = course.get("grade_number") or 0

                courses.append(
                    {
                        "course_id": course["course_id"],
                        "level_id": level_id,
                        "level_number": level_number,
                        "grade_id": grade_id,
                        "grade_number": grade_number,
                    }
                )
            data["courses"] = courses
        return data


class SchedulerShiftRequestSerializer(MatchingShiftRequestSerializer):
    shift_id = serializers.CharField()


class MatchingRequestSerializer(MatchingShiftRequestSerializer):
    worker_id = serializers.CharField(required=False, allow_blank=True)
    organisation_id = serializers.CharField()
    skip = serializers.IntegerField(min_value=0, default=0)
    limit = serializers.IntegerField(min_value=0, max_value=10, default=5)
    worker_type = serializers.ChoiceField(choices=WorkerType._member_names_)


class SchedulerRequestSerializer(serializers.Serializer):
    shifts = serializers.ListField(child=SchedulerShiftRequestSerializer())
    include_fielders = serializers.BooleanField(default=False)
    include_staff = serializers.BooleanField(default=False)

    def validate(self, attrs):
        if not attrs.get("include_fielders") and not attrs.get("include_staff"):
            raise serializers.ValidationError(
                "At least one of include_fielders or include_staff must be true"
            )
        return super().validate(attrs)


class MatchingWorker(serializers.Serializer):
    id = serializers.CharField()
    skills_score = serializers.IntegerField(min_value=0, max_value=100)
    courses_score = serializers.IntegerField(min_value=0, max_value=100)
    checks_score = serializers.IntegerField(min_value=0, max_value=100)
    availability_score = serializers.IntegerField(min_value=0, max_value=100)
    overall_score = serializers.IntegerField(min_value=0, max_value=100)
    distance = serializers.FloatField(min_value=0)


class MatchingResponseSerializer(serializers.Serializer):
    workers = serializers.ListField(child=MatchingWorker(), allow_empty=True)


class WorkerUnavailabilitySerializer(serializers.Serializer):
    date = serializers.DateField()
    end_time = serializers.IntegerField(min_value=0, max_value=172800)
    start_time = serializers.IntegerField(min_value=0, max_value=86400)


class UnavailabilitiesResponse(serializers.Serializer):
    worker_unavailabilities = serializers.ListField(
        allow_empty=True, child=WorkerUnavailabilitySerializer()
    )


class UnavailabilitiesRequest(serializers.Serializer):
    worker_id = serializers.CharField()
    organisation_id = serializers.CharField()
    group_id = serializers.CharField()
    start_date = serializers.DateField(format="%Y-%m-%d")
    end_date = serializers.DateField(format="%Y-%m-%d")

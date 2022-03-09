from datetime import datetime

from fielder_backend_utils.rest_utils import DocumentReferenceField
from rest_framework import serializers


class ValueSerializer(serializers.Serializer):
    value = serializers.CharField()


class OccupationSerializer(ValueSerializer):
    occupation_ref = DocumentReferenceField()


class SkillSerializer(serializers.Serializer):
    skill_ref = DocumentReferenceField()
    skill_value = serializers.CharField()


class CheckSerializer(serializers.Serializer):
    check_ref = DocumentReferenceField()
    check_value = serializers.CharField()


class AdditionalRequirementSerializer(serializers.Serializer):
    additional_requirement_ref = DocumentReferenceField()
    additional_requirement_value = serializers.CharField()


class CourseLevelSerializer(serializers.Serializer):
    class CourseDataSerializer(ValueSerializer):
        pass

    class LevelDataSerializer(ValueSerializer):
        level_number = serializers.IntegerField()

    course_ref = DocumentReferenceField()
    course_data = CourseDataSerializer()
    level_ref = DocumentReferenceField(allow_null=True, default=None)
    level_data = LevelDataSerializer(allow_null=True, default=None)


class BaseJobSerializer(serializers.Serializer):
    job_title = serializers.CharField()
    job_title_normalised = serializers.CharField()
    occupation = OccupationSerializer()
    checks = serializers.ListField(child=CheckSerializer(), default=[])
    skills = serializers.ListField(child=SkillSerializer(), default=[])
    additional_requirements = serializers.ListField(
        child=AdditionalRequirementSerializer(),
        default=[],
    )
    courses = serializers.ListField(child=CourseLevelSerializer(), default=[])
    organisation_data = serializers.DictField()
    organisation_ref = DocumentReferenceField()
    group_ref = DocumentReferenceField()

    def to_internal_value(self, data):
        if "job_title" in data:
            data["job_title_normalised"] = (
                data["job_title"].strip().replace("[ ]+", " ").lower()
            )
        return super().to_internal_value(data)

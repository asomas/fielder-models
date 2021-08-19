from fielder_backend_utils.rest_utils import DocumentReferenceField
from rest_framework import serializers

from .common import *


class BaseExperienceSerializer(serializers.Serializer):
    location_data = LocationDBSerializer(allow_null=True, default=None)
    start_date = serializers.DateTimeField(
        allow_null=True, default=None, input_formats=["%Y-%m-%d"]
    )
    end_date = serializers.DateTimeField(
        allow_null=True, default=None, input_formats=["%Y-%m-%d"]
    )
    summary = serializers.CharField(allow_null=True, default=None, allow_blank=True)
    worker_ref = DocumentReferenceField()
    type = serializers.ChoiceField(
        (
            ("External"),
            ("Fielder"),
            ("Education"),
        ),
    )


class WorkExperienceSerializer(BaseExperienceSerializer):
    class ReferenceSerializer(serializers.Serializer):
        value = serializers.CharField(allow_null=True)

    class OccupationSerializer(ReferenceSerializer):
        occupation_ref = DocumentReferenceField()

    class SkillSerializer(ReferenceSerializer):
        skill_ref = DocumentReferenceField()

    organisation_name = serializers.CharField(allow_null=True, default=None)
    company_number = serializers.CharField(
        allow_null=True, default=None, min_length=8, max_length=8
    )
    from_companies_house = serializers.BooleanField(allow_null=True, default=None)
    occupation = OccupationSerializer(allow_null=True, default=None)
    job_title = serializers.CharField(allow_null=True, default=None)
    skills = serializers.ListField(
        allow_null=True, default=None, child=SkillSerializer()
    )
    sic_codes = serializers.ListField(
        allow_null=True, default=None, child=SICCodeSerializer()
    )

    def to_internal_value(self, data):
        if "type" not in data:
            data["type"] = "External"
        return super().to_internal_value(data)


class FielderWorkExperienceSerializer(WorkExperienceSerializer):
    job_ref = DocumentReferenceField()
    total_hours = serializers.FloatField(default=0.0)
    total_shifts = serializers.IntegerField(default=0)

    def to_internal_value(self, data):
        if "type" not in data:
            data["type"] = "Fielder"
        return super().to_internal_value(data)


class EducationSerializer(BaseExperienceSerializer):
    class ReferenceSerializer(serializers.Serializer):
        value = serializers.CharField(allow_null=True)

    class InstitutionSerializer(ReferenceSerializer):
        institution_ref = DocumentReferenceField()

    class CourseSerializer(ReferenceSerializer):
        course_ref = DocumentReferenceField()

    class LevelSerializer(ReferenceSerializer):
        level_ref = DocumentReferenceField()

    class GradeSerializer(ReferenceSerializer):
        grade_ref = DocumentReferenceField()

    class KnowledgeAreaSerializer(ReferenceSerializer):
        knowledge_area_ref = DocumentReferenceField()

    institution = InstitutionSerializer(allow_null=True, default=None)
    location_data = LocationDBSerializer(allow_null=True, default=None)
    course = CourseSerializer(allow_null=True, default=None)
    level = LevelSerializer(allow_null=True, default=None)
    grade = GradeSerializer(allow_null=True, default=None)
    award = serializers.BooleanField(allow_null=True, default=None)
    knowledge_areas = serializers.ListField(
        allow_null=True, default=None, child=KnowledgeAreaSerializer()
    )

    def to_internal_value(self, data):
        if "type" not in data:
            data["type"] = "Education"
        return super().to_internal_value(data)


class WorkerSkillRelationSerializer(serializers.Serializer):
    worker_ref = DocumentReferenceField()
    skill_ref = DocumentReferenceField()
    skill_value = serializers.CharField()
    external_work_experience_sources = serializers.DictField(
        child=serializers.BooleanField(), default={}
    )
    sourced_from_fielder_work_experience = serializers.BooleanField(default=False)

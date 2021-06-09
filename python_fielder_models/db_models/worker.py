from fielder_backend_utils.rest_utils import DocumentReferenceField
from rest_framework import serializers

from .common import *


class WorkExperienceSerializer(serializers.Serializer):
    class ReferenceSerializer(serializers.Serializer):
        value = serializers.CharField(allow_null=True)

    class OccupationSerializer(ReferenceSerializer):
        occupation_ref = DocumentReferenceField()

    class SkillSerializer(ReferenceSerializer):
        skill_ref = DocumentReferenceField()

    organisation_name = serializers.CharField(required=False, allow_null=True)
    location_data = LocationDBSerializer(required=False, allow_null=True)
    occupation = OccupationSerializer(required=False, allow_null=True)
    job_title = serializers.CharField(required=False, allow_null=True)
    start_date = serializers.DateTimeField(required=False, allow_null=True)
    end_date = serializers.DateTimeField(required=False, allow_null=True)
    summary = serializers.CharField(required=False, allow_null=True)
    skills = serializers.ListField(
        required=False, allow_null=True, child=SkillSerializer()
    )
    sic_codes = serializers.ListField(
        required=False, allow_null=True, child=SICCodeSerializer()
    )
    worker_ref = DocumentReferenceField()
    type = serializers.ChoiceField(
        (
            ("External"),
            ("Fielder"),
            ("Education"),
        ),
        required=False,
        allow_null=True,
    )


class FielderWorkExperienceSerializer(WorkExperienceSerializer):
    job_ref = DocumentReferenceField(required=False, allow_null=True)
    total_hours = serializers.FloatField(required=False, allow_null=True)
    total_shifts = serializers.IntegerField(required=False, allow_null=True)


class EducationSerializer(serializers.Serializer):
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

    institution = InstitutionSerializer(required=False, allow_null=True)
    location_data = LocationDBSerializer(required=False, allow_null=True)
    course = CourseSerializer(required=False, allow_null=True)
    level = LevelSerializer(required=False, allow_null=True)
    grade = GradeSerializer(required=False, allow_null=True)
    award = serializers.BooleanField(required=False, allow_null=True)
    start_date = serializers.DateTimeField(required=False, allow_null=True)
    end_date = serializers.DateTimeField(required=False, allow_null=True)
    summary = serializers.CharField(required=False, allow_null=True)
    knowledge_areas = serializers.ListField(
        required=False, allow_null=True, child=KnowledgeAreaSerializer()
    )
    worker_ref = DocumentReferenceField()
    type = serializers.ChoiceField(
        (("Education"),),
        required=True,
    )


class WorkerSkillRelationSerializer(serializers.Serializer):
    worker_ref = DocumentReferenceField()
    skill_ref = DocumentReferenceField()
    skill_value = serializers.CharField()
    external_work_experience_sources = serializers.DictField(
        child=serializers.BooleanField(), default={}
    )
    sourced_from_fielder_work_experience = serializers.BooleanField(default=False)

from fielder_backend_utils.rest_utils import DocumentReferenceField
from rest_framework import serializers

from .common import *


class WorkHistorySerializer(serializers.Serializer):
    class ReferenceSerializer(serializers.Serializer):
        value = serializers.CharField(allow_null=True)

    class SICCodeSerializer(ReferenceSerializer):
        sic_code_ref = DocumentReferenceField()

    class OccupationSerializer(ReferenceSerializer):
        occupation_ref = DocumentReferenceField()

    class SkillSerializer(ReferenceSerializer):
        skill_ref = DocumentReferenceField()

    class QualificationSerializer(ReferenceSerializer):
        qualification_ref = DocumentReferenceField()

    class CheckSerializer(ReferenceSerializer):
        check_ref = DocumentReferenceField()

    organisation_name = serializers.CharField(required=False, allow_null=True)
    sic_code = SICCodeSerializer(required=False, allow_null=True)
    location = serializers.CharField(required=False, allow_null=True)
    occupation = OccupationSerializer(required=False, allow_null=True)
    start_date = serializers.RegexField(
        DATE_FIELD_REGEX, required=False, allow_null=True
    )
    end_date = serializers.RegexField(DATE_FIELD_REGEX, required=False, allow_null=True)
    summary = serializers.CharField(required=False, allow_null=True)
    skills = serializers.ListField(
        required=False, allow_null=True, child=SkillSerializer()
    )
    qualifications = serializers.ListField(
        required=False, allow_null=True, child=QualificationSerializer()
    )
    checks = serializers.ListField(
        required=False, allow_null=True, child=CheckSerializer()
    )
    worker_ref = DocumentReferenceField()

class EducationSerializer(serializers.Serializer):
    class ReferenceSerializer(serializers.Serializer):
        value = serializers.CharField(allow_null=True)

    class EducationInstitutionSerializer(ReferenceSerializer):
        education_institution_ref = DocumentReferenceField()

    class CourseSerializer(ReferenceSerializer):
        course_ref = DocumentReferenceField()

    class LevelSerializer(ReferenceSerializer):
        level_ref = DocumentReferenceField()

    class GradeSerializer(ReferenceSerializer):
        grade_ref = DocumentReferenceField()

    class KnowledgeAreaSerializer(ReferenceSerializer):
        knowledge_area_ref = DocumentReferenceField()

    education_institution = EducationInstitutionSerializer(required=False, allow_null=True)
    location = serializers.CharField(required=False, allow_null=True)
    course = CourseSerializer(required=False, allow_null=True)
    level= LevelSerializer(required=False, allow_null=True)
    grade = GradeSerializer(required=False, allow_null=True)
    award = serializers.BooleanField(required=False, allow_null=True)     
    start_date = serializers.RegexField(
        DATE_FIELD_REGEX, required=False, allow_null=True
    )
    end_date = serializers.RegexField(DATE_FIELD_REGEX, required=False, allow_null=True)
    summary = serializers.CharField(required=False, allow_null=True)
    knowledge_areas = serializers.ListField(
        required=False, allow_null=True, child=KnowledgeAreaSerializer()
    )       
    worker_ref = DocumentReferenceField()


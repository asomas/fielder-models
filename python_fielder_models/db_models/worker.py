from email.policy import default
from enum import Enum, auto

from fielder_backend_utils.rest_utils import DocumentReferenceField
from rest_framework import serializers

from ..common.worker import (
    CheckType,
    ReferencingDataSerializer,
    VerificationPath,
    WCRStatus,
)
from ..db_models import BaseDBSerializer
from .common import *


class STATUS(Enum):
    UNCHECKED = 0
    CHECKED = 1
    AWAITING_VERIFICATION = 2
    VERIFIED = 3
    REJECTED = 4


class BaseExperienceSerializer(serializers.Serializer):
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
            ("Gap"),
        ),
    )
    status = serializers.ChoiceField(
        choices=STATUS._member_names_, default=STATUS.UNCHECKED.name, required=False
    )


class WorkExperienceGapSerializer(BaseExperienceSerializer):
    has_acceptable_reference = serializers.BooleanField(default=True)
    referencing_data = ReferencingDataSerializer(
        required=False, allow_null=True, default=None
    )


class BaseWorkExperienceSerializer(BaseExperienceSerializer):
    location_data = LocationDBSerializer(allow_null=True, default=None)


class WorkExperienceSerializer(BaseWorkExperienceSerializer):
    class ReferenceSerializer(serializers.Serializer):
        value = serializers.CharField(allow_null=True)

    class OccupationSerializer(ReferenceSerializer):
        occupation_ref = DocumentReferenceField()

    class SkillSerializer(ReferenceSerializer):
        skill_ref = DocumentReferenceField()

    organisation_name = serializers.CharField(
        allow_blank=True, allow_null=True, default=None
    )
    company_number = serializers.CharField(
        allow_blank=True, allow_null=True, default=None, min_length=8, max_length=8
    )
    from_companies_house = serializers.BooleanField(allow_null=True, default=None)
    occupation = OccupationSerializer(allow_null=True, default=None)
    job_title = serializers.CharField(allow_blank=True, allow_null=True, default=None)
    skills = serializers.ListField(
        allow_null=True, default=None, child=SkillSerializer()
    )
    sic_codes = serializers.ListField(
        allow_null=True, default=None, child=SICCodeSerializer()
    )
    referencing_data = ReferencingDataSerializer(
        required=False, allow_null=True, default=None
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

        data["status"] = STATUS.VERIFIED.name
        return super().to_internal_value(data)


class EducationSerializer(BaseWorkExperienceSerializer):
    class ReferenceSerializer(serializers.Serializer):
        value = serializers.CharField(allow_null=True)

    class InstitutionSerializer(ReferenceSerializer):
        institution_ref = DocumentReferenceField()

    class CourseSerializer(ReferenceSerializer):
        course_ref = DocumentReferenceField()

    class LevelSerializer(ReferenceSerializer):
        level_ref = DocumentReferenceField()
        level_number = serializers.IntegerField()

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


class RegisteredAddressDBSerializer(LocationDBSerializer):
    dov = serializers.DateTimeField(allow_null=True, default=None)
    is_valid = serializers.BooleanField(default=False)
    worker_document_ref = DocumentReferenceField(allow_null=True, default=None)
    source = serializers.CharField(allow_null=True, default=None)
    value = LocationDBSerializer(allow_null=True, default=None)


class Status(Enum):
    UNDER_REVIEW = auto()
    VERIFIED = auto()
    REJECTED = auto()


class VerifiedBaseSerializer(serializers.Serializer):
    dov = serializers.DateTimeField(allow_null=True)
    is_valid = serializers.BooleanField(default=False)
    source = serializers.ChoiceField(
        choices=[_.name for _ in VerificationPath], allow_null=True
    )
    worker_document_ref = DocumentReferenceField(allow_null=True)


class VerifiedStringSerializer(VerifiedBaseSerializer):
    value = serializers.CharField(allow_null=True)


class VerifiedDateSerializer(VerifiedBaseSerializer):
    value = serializers.RegexField(DATE_FIELD_REGEX, allow_null=True)


class VerifiedDateTimeSerializer(VerifiedBaseSerializer):
    value = serializers.DateTimeField(allow_null=True)


class WorkerDBSerializer(serializers.Serializer):
    dob = VerifiedDateSerializer()
    full_name = VerifiedStringSerializer()
    first_name = serializers.CharField()
    last_name = serializers.CharField()


class RTWSubColSerializer(serializers.Serializer):
    verification_path = serializers.ChoiceField(
        choices=[_.name for _ in VerificationPath]
    )
    status = serializers.ChoiceField(choices=[_.name for _ in Status])
    submitted = serializers.BooleanField()
    share_code = serializers.CharField(allow_null=True)
    share_code_response = serializers.CharField(allow_null=True)
    submitted_at = serializers.DateTimeField(allow_null=True)


class WorkerDocumentDBSerializer(serializers.Serializer):
    class SumsubAddressSerializer(serializers.Serializer):
        building_number = serializers.CharField(
            required=False, allow_null=True, allow_blank=True
        )
        building_name = serializers.CharField(
            required=False, allow_null=True, allow_blank=True
        )
        flat_number = serializers.CharField(
            required=False, allow_null=True, allow_blank=True
        )
        street = serializers.CharField(
            required=False, allow_null=True, allow_blank=True
        )
        sub_street = serializers.CharField(
            required=False, allow_null=True, allow_blank=True
        )
        town = serializers.CharField(required=False, allow_null=True, allow_blank=True)
        state = serializers.CharField(required=False, allow_null=True, allow_blank=True)
        post_code = serializers.CharField(
            required=False, allow_null=True, allow_blank=True
        )
        country = serializers.CharField(
            required=False, allow_null=True, allow_blank=True
        )

    id_doc_type = serializers.CharField(
        required=False, allow_null=True, allow_blank=True
    )
    country = serializers.CharField(required=False, allow_null=True, allow_blank=True)
    first_name = serializers.CharField(
        required=False, allow_null=True, allow_blank=True
    )
    first_name_en = serializers.CharField(
        required=False, allow_null=True, allow_blank=True
    )
    last_name = serializers.CharField(required=False, allow_null=True, allow_blank=True)
    last_name_en = serializers.CharField(
        required=False, allow_null=True, allow_blank=True
    )
    valid_until = serializers.CharField(
        required=False, allow_null=True, allow_blank=True
    )
    number = serializers.CharField(required=False, allow_null=True, allow_blank=True)
    address = SumsubAddressSerializer(required=False, allow_null=True)
    dob = serializers.CharField(required=False, allow_null=True, allow_blank=True)
    is_valid = serializers.BooleanField()
    worker_ref = DocumentReferenceField()


class WorkerCheckRelationSerializer(BaseDBSerializer):
    class VerificationInfoSerializer(serializers.Serializer):
        source = serializers.CharField()
        is_valid = serializers.BooleanField()
        dov = serializers.DateTimeField()
        worker_document_ref = DocumentReferenceField()

    worker_ref = DocumentReferenceField()
    check_ref = DocumentReferenceField()
    organisation_ref = DocumentReferenceField(allow_null=True, default=None)
    check_value = serializers.CharField()
    verification_info = VerificationInfoSerializer(allow_null=True, default=None)
    status = serializers.ChoiceField(choices=WCRStatus._member_names_)
    check_type = serializers.ChoiceField(choices=CheckType._member_names_)

    def validate(self, attrs):
        if attrs.get("check_type", None) == CheckType.ORG_SPECIFIC.value:
            if not attrs.get("organisation_ref", None):
                raise serializers.ValidationError(
                    "organisation_ref is required when check_type is ORG_SPECIFIC"
                )
        return super().validate(attrs)

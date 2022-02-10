from email.policy import default
from xml.dom import ValidationErr

from django.forms import ValidationError
from fielder_backend_utils.rest_utils import DocumentReferenceField
from rest_framework import serializers

from ..api_models.common import *
from ..common.worker import ReferencingDataSerializer, VerificationPath
from ..db_models.worker import *


class BaseExperienceAPISerializer(serializers.Serializer):
    start_date = serializers.RegexField(DATE_FIELD_REGEX)
    end_date = serializers.RegexField(DATE_FIELD_REGEX)
    summary = serializers.CharField(allow_blank=True)
    status = serializers.ChoiceField(choices=STATUS._member_names_, required=False)


class WorkExperienceGapAPISerializer(BaseExperienceAPISerializer):
    has_acceptable_reference = serializers.BooleanField(default=False)
    reference_name = serializers.CharField(allow_null=True, default=None)
    reference_phone = serializers.CharField(allow_null=True, default=None)
    reference_relationship = serializers.CharField(allow_null=True, default=None)

    def validate(self, attrs):
        data = super().validate(attrs)
        if data["has_acceptable_reference"] == True:
            req_fields = ["reference_name", "reference_phone", "reference_relationship"]
            for f in req_fields:
                if data[f] is None:
                    raise ValidationError(
                        f"{f} is required when has_acceptable_reference is true."
                    )
        return data


class BaseWorkExperienceAPISerializer(BaseExperienceAPISerializer):
    location_data = LocationAPISerializer(required=False)
    google_place_data = GooglePlaceDataSerializer(required=False)

    def validate(self, data):
        if "location_data" in data and "google_place_data" in data:
            raise serializers.ValidationError(
                "Either location_data or google_place_data can be provided"
            )
        return super().validate(data)


class WorkExperienceAPISerializer(BaseWorkExperienceAPISerializer):
    class ReferenceSerializer(serializers.Serializer):
        value = serializers.CharField(allow_null=True)

    class SICCodeSerializer(ReferenceSerializer):
        sic_code_ref = DocumentReferenceField()

    class OccupationSerializer(ReferenceSerializer):
        occupation_ref = DocumentReferenceField()

    class SkillSerializer(ReferenceSerializer):
        skill_ref = DocumentReferenceField()

    company_number = serializers.CharField(
        allow_blank=True, required=False, allow_null=True, min_length=8, max_length=8
    )
    occupation = OccupationSerializer(required=False, allow_null=True)
    job_title = serializers.CharField(allow_blank=True, required=False, allow_null=True)
    from_companies_house = serializers.BooleanField(required=False, allow_null=True)
    skills = serializers.ListField(
        required=False, allow_null=True, child=SkillSerializer()
    )
    sic_codes = serializers.ListField(
        required=False, allow_null=True, child=SICCodeSerializer()
    )
    referencing_data = ReferencingDataSerializer(
        required=False, allow_null=True, default=None
    )


class FielderWorkExperienceRequestSerializer(serializers.Serializer):
    shift_activity_id = serializers.CharField()


class StaffDetailsPersnoalDetailsResponse(serializers.Serializer):
    full_name = serializers.CharField(
        required=False, allow_null=True, max_length=FULL_NAME_MAX_LENGTH
    )
    worker_reference_id = serializers.CharField(
        required=False, allow_null=True, max_length=6
    )
    preferred_name = serializers.CharField(
        required=False,
        allow_null=True,
        allow_blank=True,
        max_length=FULL_NAME_MAX_LENGTH,
    )
    address = AddressAPISerializer(required=False, allow_null=True)
    phone_number = serializers.CharField(required=False, allow_null=True)
    skills = serializers.ListField(
        required=False, allow_null=True, child=serializers.CharField()
    )
    checks = serializers.ListField(
        required=False, allow_null=True, child=serializers.CharField()
    )
    personal_statement = serializers.CharField(required=False, allow_null=True)
    has_logged_in = serializers.BooleanField(required=False)
    has_right_to_work = serializers.BooleanField(required=False)


class StaffDetailsProfessionalDetailsResponse(serializers.Serializer):
    skills = serializers.ListField(
        required=False, allow_null=True, child=serializers.CharField()
    )
    qualifications = serializers.ListField(
        required=False, allow_null=True, child=serializers.CharField()
    )
    checks = serializers.ListField(
        required=False, allow_null=True, child=serializers.CharField()
    )
    work_experiences = serializers.ListField(
        required=False, allow_null=True, child=FielderWorkExperienceSerializer()
    )
    educations = serializers.ListField(
        required=False, allow_null=True, child=EducationSerializer()
    )


class WorkerUnavailabilitySerializer(serializers.Serializer):
    date = serializers.DateField()
    end_time = serializers.IntegerField(min_value=0, max_value=86400)
    start_time = serializers.IntegerField(min_value=0, max_value=86400)


class UnavailabilitiesResponse(serializers.Serializer):
    worker_unavailabilities = serializers.ListField(
        allow_empty=True, child=WorkerUnavailabilitySerializer()
    )


class WorkerDetailRequest(serializers.Serializer):
    worker_id = serializers.CharField()
    organisation_id = serializers.CharField()


class UnavailabilitiesRequest(WorkerDetailRequest):
    start_date = serializers.RegexField(DATE_FIELD_REGEX)
    end_date = serializers.RegexField(DATE_FIELD_REGEX)


class EducationAPISerializer(BaseWorkExperienceAPISerializer):
    class ValueSerializer(serializers.Serializer):
        value = serializers.CharField(allow_null=True)

    class EducationInstitutionSerializer(ValueSerializer):
        education_institution_ref = DocumentReferenceField()

    class CourseSerializer(ValueSerializer):
        course_ref = DocumentReferenceField()

    class LevelSerializer(ValueSerializer):
        level_ref = DocumentReferenceField()

    class GradeSerializer(ValueSerializer):
        grade_ref = DocumentReferenceField()

    class KnowledgeAreaSerializer(ValueSerializer):
        knowledge_area_ref = DocumentReferenceField()

    education_institution = EducationInstitutionSerializer(
        required=False, allow_null=True
    )
    course = CourseSerializer(required=False, allow_null=True)
    level = LevelSerializer(required=False, allow_null=True)
    grade = GradeSerializer(required=False, allow_null=True)
    award = serializers.BooleanField(required=False, allow_null=True)
    knowledge_areas = serializers.ListField(
        required=False, allow_null=True, child=KnowledgeAreaSerializer()
    )


class NewsFeedDismissAPIRequestSerializer(serializers.Serializer):
    dismissed = serializers.BooleanField()


class IntercomIdentityVerifyAPIRequestSerializer(serializers.Serializer):
    user_id = serializers.CharField()
    platform = serializers.ChoiceField(choices=["ios", "android", "web"])


class OrganizationNameManualUpdate(serializers.Serializer):
    organisation_name = serializers.CharField()


class RTWShareCodeAPISerializer(serializers.Serializer):
    share_code = serializers.CharField()
    date_of_birth = serializers.DateField()


class BirthCertificateAPISerializer(serializers.Serializer):
    date_of_birth = serializers.RegexField(DATE_FIELD_REGEX)
    full_name = serializers.CharField()
    status = serializers.ChoiceField(Status._member_names_)
    worker_id = serializers.CharField()

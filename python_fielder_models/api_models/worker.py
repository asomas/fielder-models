from fielder_backend_utils.rest_utils import DocumentReferenceField
from rest_framework import serializers

from python_fielder_models.api_models.common import (
    AddressAPISerializer,
    GooglePlaceDataSerializer,
    LocationAPISerializer,
)
from python_fielder_models.common.taxonomy import OccupationSerializer, SkillSerializer
from python_fielder_models.common.worker import (
    ReferencingDataSerializer,
    SICCodeSerializer,
)
from python_fielder_models.db_models.common import (
    DATE_FIELD_REGEX,
    FULL_NAME_MAX_LENGTH,
)
from python_fielder_models.db_models.worker import (
    STATUS,
    EducationSerializer,
    FielderWorkExperienceSerializer,
    Status,
)


class BaseExperienceAPISerializer(serializers.Serializer):
    start_date = serializers.RegexField(DATE_FIELD_REGEX)
    end_date = serializers.RegexField(DATE_FIELD_REGEX, required=False)
    summary = serializers.CharField(allow_blank=True, required=False)
    status = serializers.ChoiceField(choices=STATUS._member_names_, required=False)


class WorkExperienceGapAPISerializer(BaseExperienceAPISerializer):
    has_acceptable_reference = serializers.BooleanField(default=True)
    referencing_data = ReferencingDataSerializer(required=False, allow_null=True)


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
    referencing_data = ReferencingDataSerializer(required=False, allow_null=True)


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
        institution_ref = DocumentReferenceField()

    class CourseSerializer(ValueSerializer):
        course_ref = DocumentReferenceField()

    class LevelSerializer(ValueSerializer):
        level_ref = DocumentReferenceField()

    class GradeSerializer(ValueSerializer):
        grade_ref = DocumentReferenceField()

    institution = EducationInstitutionSerializer(required=False, allow_null=True)
    course = CourseSerializer(required=False, allow_null=True)
    level = LevelSerializer(required=False, allow_null=True)
    grade = GradeSerializer(required=False, allow_null=True)
    award = serializers.BooleanField(required=False, allow_null=True)


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
    status = serializers.ChoiceField([Status.VERIFIED.name, Status.REJECTED.name])
    worker_id = serializers.CharField()


class EvaluateWorkerChecksRequestSerializer(serializers.Serializer):
    worker_id = serializers.CharField()
    organisation_id = serializers.CharField(allow_null=True, default=None)
    checks_ids = serializers.ListField(child=serializers.CharField())

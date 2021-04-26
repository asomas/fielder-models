from fielder_backend_utils.rest_utils import DocumentReferenceField
from rest_framework import serializers

from ..api_models.common import *
from ..db_models.worker import *


class WorkHistoryAPISerializer(serializers.Serializer):
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

    company_number = serializers.CharField(
        required=False, allow_null=True, min_length=8, max_length=8
    )
    google_place_data = GooglePlaceDataSerializer(required=False, allow_null=True)
    occupation = OccupationSerializer(required=False, allow_null=True)
    job_title = serializers.CharField(required=False, allow_null=True)
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


class StaffDetailsPersnoalDetailsResponse(serializers.Serializer):
    full_name = serializers.CharField(
        required=False, allow_null=True, max_length=FULL_NAME_MAX_LENGTH
    )
    preferred_name = serializers.CharField(
        required=False, allow_null=True, max_length=FULL_NAME_MAX_LENGTH
    )
    address = SumsubAddressSerializer(required=False, allow_null=True)
    phone_number = serializers.CharField(required=False, allow_null=True)
    skills = serializers.ListField(
        required=False, allow_null=True, child=serializers.CharField()
    )
    checks = serializers.ListField(
        required=False, allow_null=True, child=serializers.CharField()
    )
    personal_statement = serializers.CharField(required=False, allow_null=True)


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
    work_histories = serializers.ListField(
        required=False, allow_null=True, child=WorkHistorySerializer()
    )
    educations = serializers.ListField(
        required=False, allow_null=True, child=EducationSerializer()
    )


class WorkerUnavailabilitySerializer(serializers.Serializer):
    end_date = serializers.DateTimeField()
    end_time = serializers.IntegerField(min_value=0, max_value=86400)
    is_recurring = serializers.BooleanField()
    recurrence = RecurrenceSerializer()
    start_date = serializers.DateTimeField()
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

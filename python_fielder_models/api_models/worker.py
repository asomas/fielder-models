from fielder_backend_utils.rest_utils import DocumentReferenceField
from rest_framework import serializers

from ..db_models.common import *
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


class ValueSerializer(serializers.Serializer):
    value = serializers.CharField()


class StaffDetailsPersnoalDetailsResponse(serializers.Serializer):
    full_name = serializers.CharField(
        required=False, allow_null=True, max_length=FULL_NAME_MAX_LENGTH
    )
    prefered_name = serializers.CharField(
        required=False, allow_null=True, max_length=FULL_NAME_MAX_LENGTH
    )
    address = AddressSerializer(required=False, allow_null=True)
    phone_number = serializers.RegexField(
        PHONE_FIELD_REGEX, required=False, allow_null=True
    )
    email = serializers.EmailField()
    skills = serializers.ListField(
        required=False, allow_null=True, child=ValueSerializer()
    )
    checks = serializers.ListField(
        required=False, allow_null=True, child=ValueSerializer()
    )
    personal_statement = serializers.CharField(required=False, allow_null=True)


class StaffDetailsProfessionalDetailsResponse(serializers.Serializer):
    skills = serializers.ListField(
        required=False, allow_null=True, child=ValueSerializer()
    )
    qualifications = serializers.ListField(
        required=False, allow_null=True, child=ValueSerializer()
    )
    checks = serializers.ListField(
        required=False, allow_null=True, child=ValueSerializer()
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
    recurrence = RecurrenceSerializer()
    start_date = serializers.DateTimeField()
    start_time = serializers.IntegerField(min_value=0, max_value=86400)


class ShiftsAndAvailabilityResponse(serializers.Serializer):
    worker_unavailabilities = serializers.ListField(
        allow_empty=[], child=WorkerUnavailabilitySerializer()
    )


class WorkerDetailRquest(serializers.Serializer):
    worker_id = serializers.CharField()
    organisation_id = serializers.CharField()

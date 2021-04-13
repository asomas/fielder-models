from fielder_backend_utils.rest_utils import DocumentReferenceField
from rest_framework import serializers

from ..db_models.common import *


class WorkHistoryAPISerializer(serializers.Serializer):
    class ReferenceSerializer(serializers.Serializer):
        value = serializers.CharField(allow_null=True)

    class SICCodeSerializer(ReferenceSerializer):
        sic_code_ref = DocumentReferenceField()

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
    position = serializers.CharField(required=False, allow_null=True)
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

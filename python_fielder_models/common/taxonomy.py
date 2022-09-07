from fielder_backend_utils.rest_utils import DocumentReferenceField
from rest_framework import serializers


class SkillSerializer(serializers.Serializer):
    skill_ref = DocumentReferenceField()
    skill_value = serializers.CharField()
    relevancy_score = serializers.IntegerField(required=False)
    category = serializers.CharField(required=False)


class OccupationSerializer(serializers.Serializer):
    occupation_ref = DocumentReferenceField()
    occupation_value = serializers.CharField()
    category = serializers.CharField(required=False)

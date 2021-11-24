from rest_framework import serializers


class JobSerializer(serializers.Serializer):
    is_archived = serializers.BooleanField()

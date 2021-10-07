from rest_framework import serializers


class JobSerializer(serializers.Serialzer):
    is_archived = serializers.BooleanField()

from rest_framework import serializers


class AcceptedResponse(serializers.Serializer):
    accepted = serializers.BooleanField(default=True)

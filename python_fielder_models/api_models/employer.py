from rest_framework import serializers


class EmailExistsRequest(serializers.Serializer):
    email = serializers.EmailField()


class EmailExistsResponse(serializers.Serializer):
    user_exists = serializers.BooleanField()

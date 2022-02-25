from datetime import datetime

from rest_framework import serializers


class BaseDBSerializer(serializers.Serializer):
    created_at = serializers.DateTimeField(default=datetime.now())
    updated_at = serializers.DateTimeField(default=datetime.now())

    def to_internal_value(self, data):
        data["updated_at"] = datetime.now()
        return super().to_internal_value(data)

    def validate(self, attrs):
        try:
            return super().validate(attrs)
        except (serializers.ValidationError, serializers.DjangoValidationError) as ex:
            raise Exception(ex.detail)

    def run_validation(self, data=...):
        try:
            return super().run_validation(data)
        except (serializers.ValidationError, serializers.DjangoValidationError) as ex:
            raise Exception(ex.detail)

    def run_validators(self, value):
        try:
            return super().run_validators(value)
        except (serializers.ValidationError, serializers.DjangoValidationError) as ex:
            raise Exception(ex.detail)

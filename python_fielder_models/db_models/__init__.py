from datetime import datetime

from rest_framework import serializers


class BaseDBSerializer(serializers.Serializer):
    created_at = serializers.DateTimeField(default=datetime.now())
    updated_at = serializers.DateTimeField(default=datetime.now())

    def to_internal_value(self, data):
        data["updated_at"] = datetime.now()
        return super().to_internal_value(data)

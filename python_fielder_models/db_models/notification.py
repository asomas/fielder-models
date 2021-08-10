from fielder_backend_utils.rest_utils import DocumentReferenceField
from rest_framework import serializers
from datetime import datetime, timedelta


class MiniCardSerializer(serializers.Serializer):
    title = serializers.CharField()
    subTitle = serializers.CharField()
    worker_ref = DocumentReferenceField()
    read = serializers.BooleanField(default=False)
    read_at = serializers.DateTimeField(allow_null=True, default=None)
    created_at = serializers.DateTimeField(default=datetime.now())
    expires_at = serializers.DateTimeField(default=datetime.now() + timedelta(days=365))
    dismissed = serializers.BooleanField(default=False)
    non_dismissible = serializers.BooleanField(default=True)
    icon = serializers.URLField(allow_null=True, default=None)
    message_id = serializers.CharField()
    screen = serializers.CharField(required=False)
    type = serializers.ChoiceField(
        choices=["medium_card", "mini_card"], default="mini_card"
    )


class MediumCardSerializer(MiniCardSerializer):
    action_button_text = serializers.CharField(required=False)
    article_url = serializers.URLField(required=False)
    image = serializers.URLField()
    body = serializers.CharField()
    expanded = serializers.BooleanField(default=True)

    def to_internal_value(self, data):
        if "type" not in data:
            data["type"] = "medium_card"
        return super().to_internal_value(data)
from datetime import datetime, timedelta
from enum import Enum, auto

from fielder_backend_utils.rest_utils import DocumentReferenceField
from rest_framework import serializers


class ButtonActionName(Enum):
    POST_REQUEST = auto()
    GET_REQUEST = auto()
    NAVIGATE_SCREEN = auto()
    BROWSER = auto()


class ButtonActionSerializer(serializers.Serializer):
    action_name = serializers.ChoiceField(choices=ButtonActionName._member_names_)
    url = serializers.URLField(allow_null=True, default=None)
    payload = serializers.DictField(allow_null=True, default=None)
    screen_name = serializers.CharField(allow_null=True, default=None)


class ButtonSerializer(serializers.Serializer):
    button_text = serializers.CharField(allow_null=True, default=None)
    action = ButtonActionSerializer(allow_null=True, default=None)
    dismiss_on_press = serializers.BooleanField(default=True)


class MiniCardSerializer(serializers.Serializer):
    title = serializers.CharField()
    subTitle = serializers.CharField()
    worker_ref = DocumentReferenceField()
    read = serializers.BooleanField(default=False)
    read_at = serializers.DateTimeField(allow_null=True, default=None)
    created_at = serializers.DateTimeField(default=datetime.now())
    expires_at = serializers.DateTimeField(default=datetime.now() + timedelta(days=365))
    dismissed = serializers.BooleanField(default=False)
    non_dismissible = serializers.BooleanField(default=False)
    icon = serializers.CharField(allow_null=True, default=None)
    buttons = serializers.ListField(
        child=ButtonSerializer(), allow_empty=True, default=[]
    )
    message_id = serializers.CharField()
    type = serializers.ChoiceField(
        choices=["medium_card", "mini_card"], default="mini_card"
    )


class MediumCardSerializer(MiniCardSerializer):
    image = serializers.CharField(allow_null=True, default=None)
    body = serializers.CharField()
    expanded = serializers.BooleanField(default=True)

    def to_internal_value(self, data):
        if "type" not in data:
            data["type"] = "medium_card"
        return super().to_internal_value(data)

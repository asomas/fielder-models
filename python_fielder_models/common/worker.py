from enum import Enum, auto

from rest_framework.fields import CharField
from rest_framework.serializers import Serializer


class VerificationPath(Enum):
    PASSPORT = auto()
    BIRTH_CERTIFICATE = auto()
    BRP = auto()
    SHARE_CODE = auto()


class ReferencingDataSerializer(Serializer):
    contact_name = CharField(allow_null=True, default=None)
    contact_phone = CharField(allow_null=True, default=None)
    contact_position = CharField(allow_null=True, default=None)
    contact_email = CharField(allow_null=True, default=None)
    contact_relationship = CharField(allow_null=True, default=None)

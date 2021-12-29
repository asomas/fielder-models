from enum import Enum, auto

from rest_framework.fields import CharField
from rest_framework.serializers import Serializer


class VerificationPath(Enum):
    PASSPORT = auto()
    BIRTH_CERTIFICATE = auto()
    BRP = auto()
    SHARE_CODE = auto()


class ReferencingDataSerializer(Serializer):
    contact_name = CharField()
    contact_phone = CharField()
    contact_position = CharField()
    contact_email = CharField()

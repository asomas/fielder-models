from enum import Enum, auto

from rest_framework.fields import CharField
from rest_framework.serializers import Serializer


class VerificationPath(Enum):
    PASSPORT = auto()
    BIRTH_CERTIFICATE = auto()
    BRP = auto()
    SHARE_CODE = auto()


class ExperienceType(Enum):
    EXTERNAL = "External"
    FIELDER = "Fielder"
    EDUCATION = "Education"
    GAP = "Gap"


class ReferencingDataSerializer(Serializer):
    contact_name = CharField(allow_null=True, required=False)
    contact_phone = CharField(allow_null=True, required=False)
    contact_position = CharField(allow_null=True, required=False)
    contact_email = CharField(allow_null=True, required=False)
    contact_relationship = CharField(allow_null=True, required=False)


class WCRStatus(Enum):
    AWAITING_BACKOFFICE = auto()
    CONFIRMED = auto()
    INVALIDATED = auto()


class CheckType(Enum):
    GLOBAL = auto()
    ORG_SPECIFIC = auto()

from enum import Enum, auto


class VerificationPath(Enum):
    PASSPORT = auto()
    BIRTH_CERTIFICATE = auto()
    BRP = auto()
    SHARE_CODE = auto()

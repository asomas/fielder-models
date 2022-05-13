from enum import Enum, auto


class OrgInvitationStatus(Enum):
    ACCEPTED = auto()
    DECLINED = auto()
    PENDING_CHECKS_BACKOFFICE = auto()
    PENDING_CHECKS_WORKER = auto()
    PENDING_WORKER_FINAL_CONFIRMATION = auto()
    PENDING_WORKER_RESPONSE = auto()
    QUEUED = auto()
    RETRACTED = auto()

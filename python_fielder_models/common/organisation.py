from enum import Enum, auto


class OrgInvitationStatus(Enum):
    ACCEPTED = "Worker accepted invitation"
    DECLINED = "Worker declined invitation"
    PENDING_CHECKS_BACKOFFICE = "Awaiting Fielder verification"
    PENDING_CHECKS_WORKER = "Worker completing checks"
    PENDING_WORKER_FINAL_CONFIRMATION = "Awaiting worker confirmation"
    PENDING_WORKER_RESPONSE = "Invited to team"
    QUEUED = auto()
    RETRACTED = "Invitation retracted"

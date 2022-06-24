class OffersStatusString {
  static const String accepted = 'ACCEPTED';
  static const String declined = 'DECLINED';
  static const String pendingChecksBackoffice = 'PENDING_CHECKS_BACKOFFICE';
  static const String pendingChecksWorker = 'PENDING_CHECKS_WORKER';
  static const String pendingWorkerFinalConfirmation =
      'PENDING_WORKER_FINAL_CONFIRMATION';
  static const String pendingWorkerResponse = 'PENDING_WORKER_RESPONSE';
  static const String queued = 'QUEUED';
  static const String retracted = 'RETRACTED';
  static const String expired = 'EXPIRED';
  static const String none = 'NONE';
  static const String invitedForInterview = 'INVITED_FOR_INTERVIEW';
  static const String interviewScheduled = 'INTERVIEW_SCHEDULED';
}

class OffersStatusUIString {
  static const String invitedForInterview = 'Invited to interview';
  static const String interviewScheduled = 'Interview scheduled';
  static const String pendingWorkerResponse = 'Invited to team';
  static const String pendingChecksWorker = 'Worker completing checks';
  static const String pendingChecksBackoffice = 'Awaiting fielder verification';
  static const String pendingWorkerFinalConfirmation =
      'Waiting for worker confirmation';
  static const String workerResponded = 'Worker Responded';
  static const String accepted = 'Accepted';
  static const String declined = 'Declined';
  static const String retracted = 'Retracted';
}

class OffersSchema {
  static const String status = 'status';
}

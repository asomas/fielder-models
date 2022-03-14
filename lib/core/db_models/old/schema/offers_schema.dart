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
}

class OffersSchema {
  static const String status = 'status';
}

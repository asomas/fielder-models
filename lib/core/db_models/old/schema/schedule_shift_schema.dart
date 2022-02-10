class ScheduleShiftSchema {
  static const String scheduleId = "schedule_id";
  static const String organisationRef = "organisation_ref";
  static const String organisationUserRef = "organisation_user_ref";
  static const String progressPercent = "progress_percent";
  static const String status = "status";
  static const String step = "step";
  static const String result = "result";
  static const String statusMessage = "status_message";
  static const String data = "data";
  static const String shiftPatterns = "shift_patterns";
  static const String shiftPatternRef = "shift_pattern_ref";
  static const String workerRef = "worker_ref";
  static const String startDate = "start_date";
  static const String endDate = "end_date";
  static const String workerData = "worker_data";
}

class ScheduleShiftStatusString {
  static const String success = "success";
  static const String fail = "fail";
  static const String notStarted = "not_started";
  static const String inProgress = "in_progress";
  static const String complete = "complete";
  static const String failed = "failed";
}

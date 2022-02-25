class ScheduleShiftSchema {
  static const String scheduleId = "schedule_id";
  static const String organisationRef = "organisation_ref";
  static const String organisationUserRef = "organisation_user_ref";
  static const String progressPercent = "progress_percent";
  static const String status = "status";
  static const String step = "step_message";
  static const String result = "result";
  static const String statusMessage = "status_message";
  static const String data = "data";
  static const String shifts = "shifts";
  static const String shiftPatternRef = "shift_pattern_ref";
  static const String shiftId = "shift_id";
  static const String workerRef = "worker_ref";
  static const String startDate = "start_date";
  static const String endDate = "end_date";
  static const String workerData = "worker_data";
  static const String includeFielders = "include_fielders";
  static const String includeStaff = "include_staff";
  static const String archived = "archived";
  static const String updatedAt = "updated_at";
  static const String assignments = "assignments";
  static const String workerId = "worker_id";
  static const String shiftPatternId = "shift_pattern_id";
}

class ScheduleShiftStatusString {
  static const String success = "SUCCESS";
  static const String fail = "FAILURE";
  static const String notStarted = "NOT_STARTED";
  static const String inProgress = "IN_PROGRESS";
  static const String complete = "COMPLETED";
  static const String failed = "FAILED";
  static const String cancelled = "CANCELLED";
}

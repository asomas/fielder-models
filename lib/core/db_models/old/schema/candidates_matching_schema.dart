class CandidatesMatchingSchema {
  static const String id = "id";
  static const String workerId = "worker_id";
  static const String isStaff = "is_staff";
  static const String firstName = "first_name";
  static const String lastName = "last_name";
  static const String pictureUrl = "picture_url";
  static const String skillsScore = "skills_score";
  static const String qualificationsScore = "qualifications_score";
  static const String checksScore = "checks_score";
  static const String availabilityScore = "availability_score";
  static const String overallScore = "overall_score";
}

class CandidatesMatchingRequestSchema {
  static const String organisationId = "organisation_id";
  static const String workerId = "worker_id";
  static const String isStaff = "is_staff";
  static const String startDate = "start_date";
  static const String endDate = "end_date";
  static const String startTime = "start_time";
  static const String endTime = "end_time";
  static const String recurrence = "recurrence";
  static const String skills = "skills";
  static const String qualifications = "qualifications";
  static const String checks = "checks";
  static const String skip = "skip";
  static const String limit = "limit";
}

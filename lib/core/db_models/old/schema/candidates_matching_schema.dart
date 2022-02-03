class CandidatesMatchingSchema {
  static const String id = "id";
  static const String workerId = "worker_id";
  static const String isStaff = "is_staff";
  static const String firstName = "first_name";
  static const String lastName = "last_name";
  static const String pictureUrl = "picture_url";
  static const String skillsScore = "skills_score";
  static const String coursesScore = "courses_score";
  static const String checksScore = "checks_score";
  static const String availabilityScore = "availability_score";
  static const String overallScore = "overall_score";
  static const String distance = "distance";
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
  static const String courses = "courses";
  static const String checks = "checks";
  static const String skip = "skip";
  static const String limit = "limit";
  static const String workerType = "worker_type";
  static const String jobId = 'job_id';
  static const String shiftPatternId = 'shift_pattern_id';
  static const String staff = 'staff';
  static const String badMatch = 'bad_match';
  static const String fielders = 'fielders';
  static const String network = 'network';
}

class HoverMatchingSchema {
  static const String id = "id";
  static const String availabilities = "availabilities";
  static const String skills = "skills";
  static const String checks = "checks";
  static const String courses = "courses";
  static const String distance = "distance";
  static const String value = "value";
}

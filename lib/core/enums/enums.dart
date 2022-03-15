enum AddJobSubViews {
  Description,
  Skills,
  Shift,
  Rate,
  Preview,
  Completed,
}

enum SideMenuItems {
  Dashboard,
  BusinessSetup,
  MyJobs,
  MyStaff,
  Schedule,
  OrganisationSetup,
  Settings,
  Payment
}

enum SlotStatus {
  Normal,
  // VERY_BUSY,
  // MILD,
  // UNSIGNED,
  Empty,
  Assigned,
  ShiftStarted,
  ShiftFinished,
  // COMPLETED,
  // UPCOMING,
  // NOT_AVAILABLE,
  // RECOMMEND_FRIEND,
}

enum UserJobInfoEnum {
  description,
  shiftPattern,
  skills,
  payment,
  hire,
}

enum EndDateTypes {
  NoEndDate,
  EndOn,
  EndAfter,
}

enum ShiftFrequencies {
  None,
  Daily,
  Weekly,
  TwoWeeks,
}

enum RepeatInterval {
  Weekly,
  EveryTwoWeeks,
}

enum OverlayType { ERROR, SUCCESS, WARNING }

enum CalculatePay { ShiftHours, ClockedInHours }

enum CalendarType { date, time, none }

enum AssignJobCard { Staff, Fielder, FielderNetwork, Interview }

enum OfferStatus { Queued, Pending, Rejected, Accepted, Expired, None }

enum GenericOverlayType { Jobs, AssignJob }

enum ShiftTimeType { start, end, none }

enum SlotType {
  InactiveRecurring,
  InactiveNonRecurring,
  ActiveRecurring,
  ActiveNonRecurring,
  ActiveLate,
  ActiveMissed,
  ActiveCompleted,
}

enum BrandingImageType { Logo, Banner }

enum RenderSlot {
  Single,
  Week,
}

enum WorkerType {
  Fielder,
  Staff,
}

enum ShiftAssignStatus { Assign, Unassign, Pending }

enum OrganisationContractStatus { NotSigned, InReview, Signed }

enum NewsCardType { Mini, Medium }

enum SalaryType { Hourly, Daily, Weekly, Monthly, Yearly }

enum InviteStaffStatus { Pending, Accepted, Declined, None }

enum CandidatesWorkerType { STAFF, FIELDER, NETWORK }

enum RightToWorkFlow { Passport, BirthCertificate, BRP, ShareCode, None }
enum RightToWorkVerificationStatus { UnderReview, Verified, Rejected, None }

enum InterviewType { Video, InPerson, NoInterview }

enum ChecksType { DBS, EnhancedDBS, ProofOfID }

enum MatchingHoverType { Availability, Skills, Checks, Courses, Location }

enum GroupRole { Manager, Supervisor }

enum ScheduleShiftStatus {
  NotStarted,
  InProgress,
  Completed,
  Failed,
  Cancelled
}
enum ScheduleShiftResultStatus { Success, Fail }

enum WelcomeCarouselItemType { Image, Video }

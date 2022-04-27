enum AddJobSubViews {
  Description,
  Skills,
  Shift,
  Rate,
  Preview,
  Completed,
}

enum SideMenuItems {
  GettingStarted,
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
  CustomDay,
  Weekdays,
  Weekends,
  Daily,
  TwoWeeks,
  Weekly,
}

enum RepeatInterval {
  Weekly,
  EveryTwoWeeks,
}

enum OverlayType { ERROR, SUCCESS, WARNING }

enum CalculatePay { ShiftHours, ClockedInHours }

enum CalendarType { date, time, none }

enum AssignJobCard { Staff, Fielder, FielderNetwork, Interview }

enum OfferStatus {
  Queued,
  Retracted,
  Accepted,
  Declined,
  Expired,
  None,
  PendingChecksBackOffice,
  PendingChecksWorker,
  PendingWorkerFinalConfirmation,
  PendingWorkerResponse
}

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

enum ChecksType { DBS, EnhancedDBS, ProofOfID, ProofOfAddress }

enum MatchingHoverType { Availability, Skills, Checks, Courses, Location }

enum GroupRole { Manager, Supervisor }

enum ScheduleShiftStatus {
  NotStarted,
  InProgress,
  Completed,
  Failed,
  Cancelled
}
enum WelcomeCarouselItemType { Image, Video, YoutubeVideo }

enum ScheduleShiftResultStatus { Success, Fail }

enum OnBoardingDocumentSignStatus { Signed, Unsigned }

enum CheckStatus { Confirmed }

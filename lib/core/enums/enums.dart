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
  PendingWorkerResponse,
  InvitedForInterview,
  InterviewScheduled,
  WorkerResponded,
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

enum NewsCardAction { PostRequest, GetRequest, NavigateScreen, Browser }

enum SalaryType { Hourly, Daily, Weekly, Monthly, Yearly }

//enum InviteStaffStatus { Pending, Accepted, Declined, None }

enum CandidatesWorkerType { STAFF, FIELDER, NETWORK }

enum RightToWorkVerificationPath {
  Passport,
  BirthCertificate,
  BRP,
  ShareCode,
}

enum RTWCheckDocumentsEnum {
  CitizenWithPassport,
  CitizenWithoutPassport,
  NotCitizenWithBRP,
  NotCitizenWithoutBRP,
}

enum VerificationStatus { UnderReview, Verified, Rejected, None }

enum InterviewType { Video, InPerson, NoInterview }

enum CheckTypeFromValue {
  DBS,
  EnhancedDBS,
  ProofOfID,
  ProofOfAddress,
  ExperiencesReferenced,
  WorkHistory,
  RightToWork,
  OnBoarding,
  ApprovedGaps,
  LoggedIn
}

enum CheckType {
  Global,
  OrgSpecific,
}

enum SkillPriority { important, desirable, none }

enum MatchingHoverType { Availability, Skills, Checks, Courses, Location }

enum GroupRole { Manager, Supervisor }

enum ScheduleShiftStatus {
  NotStarted,
  InProgress,
  Completed,
  Failed,
  Cancelled
}

enum MediaType { Image, Video, YoutubeVideo }

enum ScheduleShiftResultStatus { Success, Fail }

enum OnBoardingDocumentSignStatus { Signed, Unsigned }

enum CheckStatus { Confirmed, Invalidated, AwaitingBackOffice, NotStarted }

enum Trending { Up, Down }

enum EducationApprovalStatus { Signed, Unsigned }

enum SupportVideosEnums {
  JobSummary,
  StaffSummary,
  NotificationsSummary,
  CreateShift,
  AssignShift,
  GetHelp,
  OrganisationSetup,
  ManageStaff,
}

enum ReasonForLeavingApp {
  FoundOtherWork,
  AppConfusing,
  NotOfferedJob,
  NotHappySupport,
  AppNotTrustworthy,
  Other,
}

enum ExperienceType { EXTERNAL, FIELDER, EDUCATION, GAP }

enum ExperienceVerificationStatus {
  Unchecked,
  Checked,
  AwaitingVerification,
  Verified,
  Rejected
}

enum RefereeFields { Name, Phone, Position }

enum BudgetServiceType {
  FielderHire,
  FielderPayroll,
}

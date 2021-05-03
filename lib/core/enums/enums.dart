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
  Daily,
  None,
  Weekly,
}

enum OverlayType { ERROR, SUCCESS, WARNING }

enum CalculatePay { ShiftHours, ClockedInHours }

enum CalendarType { date, time, none }


enum AssignJobCard {
  Staff,
  Fielder
}

enum OfferStatus {
  Pending,
  Rejected,
  Accepted,
  None
}

enum GenericOverlayType {
  Jobs,
  AssignJob
}

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

enum BrandingImageType{
  Logo,
  Banner
}

enum RenderSlot {
  Single,
  Week,
}

enum WorkerType {
  Fielder,
  Staff,
}

enum ShiftAssignStatus {
  Assign,
  Unassign,
  Pending
}


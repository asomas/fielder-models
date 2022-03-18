import 'package:fielder_models/core/constants/app_colors.dart';
import 'package:fielder_models/core/constants/app_strings.dart';
import 'package:fielder_models/core/db_models/old/schema/company_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/offers_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/schedule_shift_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/staff_status_schema.dart';
import 'package:fielder_models/core/db_models/temp/common.dart';
import 'package:fielder_models/core/db_models/worker/schema/newsNotificationSchema.dart';
import 'package:fielder_models/core/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:number_to_words/number_to_words.dart';

class EnumHelpers {
  static OrganisationContractStatus contractStatusTypeFromString(String type) {
    switch (type) {
      case CompanySchema.contractInReview:
        return OrganisationContractStatus.InReview;
      case CompanySchema.contractSigned:
        return OrganisationContractStatus.Signed;
      case CompanySchema.contractNotSigned:
        return OrganisationContractStatus.NotSigned;
      default:
        return OrganisationContractStatus.NotSigned;
    }
  }

  static String stringFromContractSignStatus(OrganisationContractStatus type) {
    switch (type) {
      case OrganisationContractStatus.InReview:
        return CompanySchema.contractInReview;
      case OrganisationContractStatus.Signed:
        return CompanySchema.contractSigned;
      case OrganisationContractStatus.NotSigned:
        return CompanySchema.contractNotSigned;
      default:
        return CompanySchema.contractNotSigned;
    }
  }

  static WorkerType workerTypeFromString(String type) {
    switch (type) {
      case UploadCsvSchema.myFielder:
        return WorkerType.Fielder;
      case UploadCsvSchema.myStaff:
        return WorkerType.Staff;
      default:
        return null;
    }
  }

  static String stringFromWorkerType(WorkerType type) {
    switch (type) {
      case WorkerType.Fielder:
        return UploadCsvSchema.myFielder;
      case WorkerType.Staff:
        return UploadCsvSchema.myStaff;
      default:
        return "";
    }
  }

  static OfferStatus getOfferStatusFromString(String status) {
    status = status.toUpperCase();
    switch (status) {
      case OffersStatusString.pendingChecksBackoffice:
        return OfferStatus.PendingChecksBackOffice;
      case OffersStatusString.pendingChecksWorker:
        return OfferStatus.PendingChecksWorker;
      case OffersStatusString.pendingWorkerFinalConfirmation:
        return OfferStatus.PendingWorkerFinalConfirmation;
      case OffersStatusString.pendingWorkerResponse:
        return OfferStatus.PendingWorkerResponse;
      case OffersStatusString.queued:
        return OfferStatus.Queued;
      case OffersStatusString.accepted:
        return OfferStatus.Accepted;
      case OffersStatusString.declined:
        return OfferStatus.Declined;
      case OffersStatusString.retracted:
        return OfferStatus.Retracted;
      case OffersStatusString.expired:
        return OfferStatus.Expired;
      default:
        return OfferStatus.None;
    }
  }

  static String getStringForPayType(CalculatePay calculatePay) {
    switch (calculatePay) {
      case CalculatePay.ClockedInHours:
        return 'Actual hours';
      case CalculatePay.ShiftHours:
        return 'Shift hours';
      default:
        return '';
    }
  }

  static CalculatePay getPayTypeFromString(String calculatePay) {
    switch (calculatePay) {
      case 'Actual hours':
        return CalculatePay.ClockedInHours;
      case 'Shift hours':
        return CalculatePay.ShiftHours;
      default:
        return CalculatePay.ClockedInHours;
    }
  }

  static String getStringForFrequency({
    @required ShiftFrequencies shiftPatternFrequency,
  }) {
    switch (shiftPatternFrequency) {
      case ShiftFrequencies.Daily:
        return 'Daily';
      case ShiftFrequencies.None:
        return 'Does not repeat';
      case ShiftFrequencies.Weekly:
        return 'Weekly';
      case ShiftFrequencies.TwoWeeks:
        return 'Every two weeks';
      default:
        return '';
    }
  }

  static ShiftFrequencies getFrequencyForString({
    @required String shiftPatternFrequency,
  }) {
    switch (shiftPatternFrequency) {
      case 'Daily':
        return ShiftFrequencies.Daily;
      case 'None':
        return ShiftFrequencies.None;
      case 'Weekly':
        return ShiftFrequencies.Weekly;
      default:
        return ShiftFrequencies.None;
    }
  }

  static String getStringForRepeatIntervals(
      {@required RepeatInterval repeatInterval,
      @required ShiftFrequencies shiftFrequencies}) {
    if (shiftFrequencies == ShiftFrequencies.Daily) {
      switch (repeatInterval) {
        case RepeatInterval.Weekly:
          return 'Daily';
        case RepeatInterval.EveryTwoWeeks:
          return 'Every Other Day';
        default:
          return 'None';
      }
    } else if (shiftFrequencies == ShiftFrequencies.Weekly) {
      switch (repeatInterval) {
        case RepeatInterval.Weekly:
          return 'Weekly';
        case RepeatInterval.EveryTwoWeeks:
          return 'Every Two Weeks';
        default:
          return 'None';
      }
    } else {
      return 'None';
    }
  }

  static int getIntForRepeatIntervals(
      {@required RepeatInterval repeatInterval}) {
    switch (repeatInterval) {
      case RepeatInterval.Weekly:
        return 1;
      case RepeatInterval.EveryTwoWeeks:
        return 2;
      default:
        return 1;
    }
  }

  static String getStringForIntInterval(
      {@required int repeatInterval,
      @required ShiftFrequencies shiftFrequencies}) {
    if (shiftFrequencies == ShiftFrequencies.Weekly) {
      if (repeatInterval == 1) {
        return "Every Week";
      } else if (repeatInterval == 2) {
        return "Every Two Weeks";
      } else {
        return "Every ${convertIntToStrNumber(repeatInterval)} Weeks";
      }
    } else if (shiftFrequencies == ShiftFrequencies.Daily) {
      if (repeatInterval == 1) {
        return "Everyday";
      } else if (repeatInterval == 2) {
        return "Every Other Day";
      } else {
        return "Every ${convertIntToStrNumber(repeatInterval)} Days";
      }
    } else {
      return "Non Repeating";
    }
  }

  static convertIntToStrNumber(int num) {
    return NumberToWord().convert('en-in', num);
  }

  static String getActivePageStringFor({
    @required SideMenuItems sideMenuItems,
  }) {
    switch (sideMenuItems) {
      case SideMenuItems.Dashboard:
        return AppStrings.dashBoard;
      case SideMenuItems.MyJobs:
        return AppStrings.jobs;
      case SideMenuItems.MyStaff:
        return AppStrings.staff;
      case SideMenuItems.Schedule:
        return AppStrings.schedule;

      case SideMenuItems.OrganisationSetup:
        return AppStrings.organisationSetup;

      case SideMenuItems.Payment:
        return AppStrings.payment;
      case SideMenuItems.Settings:
        return AppStrings.settings;
      default:
        return '';
    }
  }

  static SideMenuItems getSideMenuItemsForString({
    @required String sideMenuItems,
  }) {
    switch (sideMenuItems) {
      case AppStrings.dashBoard:
        return SideMenuItems.Dashboard;
      case AppStrings.jobs:
        return SideMenuItems.MyJobs;
      case AppStrings.staff:
        return SideMenuItems.MyStaff;
      case AppStrings.schedule:
        return SideMenuItems.Schedule;

      case AppStrings.organisationSetup:
        return SideMenuItems.OrganisationSetup;

      case AppStrings.payment:
        return SideMenuItems.Payment;
      case AppStrings.settings:
        return SideMenuItems.Settings;

      default:
        return SideMenuItems.Dashboard;
    }
  }

  static Color getSlotColor({
    @required SlotStatus slotStatus,
  }) {
    switch (slotStatus) {
      case SlotStatus.Empty:
        return Colors.transparent;
        break;
      case SlotStatus.Normal:
        return AppColors.PinkSalmon;
      // case SlotStatus.MILD:
      //   return AppColors.Kournikova;
      // case SlotStatus.VERY_BUSY:
      //   return AppColors.Scooter;
      default:
        return AppColors.CaribbeanGreen;
    }
  }

  static NewsCardType newsCardTypeFomString(String type) {
    switch (type) {
      case NewsNotificationSchema.mediumCard:
        return NewsCardType.Medium;
      case NewsNotificationSchema.miniCard:
        return NewsCardType.Mini;
      default:
        return NewsCardType.Medium;
    }
  }

  static String stringFromNewsCardType(NewsCardType type) {
    switch (type) {
      case NewsCardType.Mini:
        return NewsNotificationSchema.miniCard;
      case NewsCardType.Medium:
        return NewsNotificationSchema.mediumCard;
      default:
        return NewsNotificationSchema.mediumCard;
    }
  }

  static String stringFromSalary(SalaryType type) {
    switch (type) {
      case SalaryType.Yearly:
        return 'YEARLY';
      case SalaryType.Monthly:
        return 'MONTHLY';
      case SalaryType.Weekly:
        return 'WEEKLY';
      case SalaryType.Daily:
        return 'DAILY';
      default:
        return 'HOURLY';
    }
  }

  static InviteStaffStatus inviteStaffStatusFromString(String status) {
    switch (status) {
      case 'Pending':
        return InviteStaffStatus.Pending;
      case 'Declined':
        return InviteStaffStatus.Declined;
      case 'Accepted':
        return InviteStaffStatus.Accepted;
      default:
        return InviteStaffStatus.None;
    }
  }

  static String stringFromInviteStaffStatus(InviteStaffStatus status) {
    switch (status) {
      case InviteStaffStatus.Pending:
        return 'Pending';
      case InviteStaffStatus.Declined:
        return 'Declined';
      case InviteStaffStatus.Accepted:
        return 'Accepted';
      default:
        return null;
    }
  }

  static String stringFromCandidatesWorkerType(
      CandidatesWorkerType workerType) {
    switch (workerType) {
      case CandidatesWorkerType.FIELDER:
        return 'FIELDER';
      case CandidatesWorkerType.STAFF:
        return 'STAFF';
      case CandidatesWorkerType.NETWORK:
        return 'NETWORK';
      default:
        return '';
    }
  }

  static CandidatesWorkerType candidatesWorkerTypeFromString(
      String workerType) {
    switch (workerType) {
      case 'FIELDER':
        return CandidatesWorkerType.FIELDER;
      case 'STAFF':
        return CandidatesWorkerType.STAFF;
      case 'NETWORK':
        return CandidatesWorkerType.NETWORK;
      default:
        return null;
    }
  }

  static RightToWorkFlow rightToWorkFlowFromString(String flowName) {
    switch (flowName) {
      case 'PASSPORT':
        return RightToWorkFlow.Passport;
      case 'BIRTH_CERTIFICATE':
        return RightToWorkFlow.BirthCertificate;
      case 'BRP':
        return RightToWorkFlow.BRP;
      case 'SHARE_CODE':
        return RightToWorkFlow.ShareCode;
      default:
        return RightToWorkFlow.None;
    }
  }

  static RightToWorkVerificationStatus rightToWorkVerificationStatusFromString(
      String status) {
    switch (status) {
      case 'UNDER_REVIEW':
        return RightToWorkVerificationStatus.UnderReview;
      case 'VERIFIED':
        return RightToWorkVerificationStatus.Verified;
      case 'REJECTED':
        return RightToWorkVerificationStatus.Rejected;
      default:
        return RightToWorkVerificationStatus.None;
    }
  }

  static OverlayType overlayTypeFromString(String type) {
    switch (type) {
      case 'error':
        return OverlayType.ERROR;
      case 'warning':
        return OverlayType.WARNING;
      default:
        return OverlayType.SUCCESS;
    }
  }

  static InviteStaffStatus offerStatusToInviteStatus(OfferStatus status) {
    switch (status) {
      case OfferStatus.None:
        return InviteStaffStatus.None;
      case OfferStatus.Declined:
        return InviteStaffStatus.Declined;
      case OfferStatus.Accepted:
        return InviteStaffStatus.Accepted;
      default:
        return InviteStaffStatus.Pending;
    }
  }

  static String interviewTypeFromString(InterviewType interviewType) {
    switch (interviewType) {
      case InterviewType.Video:
        return 'VIDEO';
      case InterviewType.InPerson:
        return 'IN_PERSON';
      case InterviewType.NoInterview:
        return 'NO_INTERVIEW';
      default:
        return '';
    }
  }

  static String dropDownStringForInterviewType(InterviewType interviewType) {
    switch (interviewType) {
      case InterviewType.Video:
        return 'Video';
      case InterviewType.InPerson:
        return 'In Person';
      default:
        return '';
    }
  }

  static InterviewType getInterviewType(String interviewType) {
    switch (interviewType) {
      case 'VIDEO':
        return InterviewType.Video;
      case 'IN_PERSON':
        return InterviewType.InPerson;
      case 'NO_INTERVIEW':
        return InterviewType.NoInterview;
      default:
        return null;
    }
  }

  static ChecksType getChecksTypeFromString(String value) {
    if (value.toUpperCase().startsWith('DBS'.toUpperCase())) {
      return ChecksType.DBS;
    } else if (value.toUpperCase().startsWith('Enhanced DBS'.toUpperCase())) {
      return ChecksType.EnhancedDBS;
    } else if (value.toUpperCase().startsWith('Proof of ID'.toUpperCase())) {
      return ChecksType.ProofOfID;
    } else {
      return null;
    }
  }

  static ScheduleShiftStatus getScheduleShiftStatusFromString(String status) {
    switch (status) {
      case ScheduleShiftStatusString.notStarted:
        return ScheduleShiftStatus.NotStarted;
      case ScheduleShiftStatusString.inProgress:
        return ScheduleShiftStatus.InProgress;
      case ScheduleShiftStatusString.complete:
        return ScheduleShiftStatus.Completed;
      case ScheduleShiftStatusString.failed:
        return ScheduleShiftStatus.Failed;
      case ScheduleShiftStatusString.cancelled:
        return ScheduleShiftStatus.Cancelled;
      default:
        return ScheduleShiftStatus.NotStarted;
    }
  }

  static ScheduleShiftResultStatus getScheduleShiftResultStatusFromString(
      String status) {
    switch (status) {
      case ScheduleShiftStatusString.success:
        return ScheduleShiftResultStatus.Success;
      case ScheduleShiftStatusString.failed:
        return ScheduleShiftResultStatus.Fail;
      default:
        return null;
    }
  }

  static String getStringFromScheduleShiftStatus(ScheduleShiftStatus status) {
    switch (status) {
      case ScheduleShiftStatus.NotStarted:
        return ScheduleShiftStatusString.notStarted;
      case ScheduleShiftStatus.InProgress:
        return ScheduleShiftStatusString.inProgress;
      case ScheduleShiftStatus.Cancelled:
        return ScheduleShiftStatusString.cancelled;
      case ScheduleShiftStatus.Completed:
        return ScheduleShiftStatusString.complete;
      case ScheduleShiftStatus.Failed:
        return ScheduleShiftStatusString.failed;
      default:
        return ScheduleShiftStatusString.notStarted;
    }
  }

  static Roles getRole(String role) {
    role = role.toLowerCase();
    Roles userRole = Roles.OWNER;
    if (role == 'owner') {
      userRole = Roles.OWNER;
    } else if (role == "admin") {
      userRole = Roles.ADMIN;
    } else if (role == "group_user" || role == 'group member') {
      userRole = Roles.GROUP_MEMBER;
    }

    return userRole;
  }

  // static String getRoleString(Roles role) {
  //   String userRole = "owner";
  //   if (role == Roles.OWNER) {
  //     userRole = "owner";
  //   } else if (role == Roles.MANAGER) {
  //     userRole = "manager";
  //   } else if (role == Roles.SUPERVISOR) {
  //     userRole = "supervisor";
  //   } else if (role == Roles.ADMIN) {
  //     userRole = "admin";
  //   } else if (role == Roles.HR) {
  //     userRole = "hr";
  //   } else if (role == Roles.GROUP_MEMBER) {
  //     userRole = "group_user";
  //   }
  //   return userRole;
  // }

  static AcceptanceStatus getAcceptanceStatus(String status) {
    status = status.toLowerCase();
    AcceptanceStatus acceptanceStatus = AcceptanceStatus.ACCEPTED;
    if (status == 'accepted') {
      acceptanceStatus = AcceptanceStatus.ACCEPTED;
    } else if (status == 'declined') {
      acceptanceStatus = AcceptanceStatus.DECLINED;
    } else if (status == 'pending') {
      acceptanceStatus = AcceptanceStatus.PENDING;
    }
    return acceptanceStatus;
  }

  static String getStringFromAcceptanceStatus(AcceptanceStatus status) {
    if (status == AcceptanceStatus.ACCEPTED) {
      return 'Accepted';
    } else if (status == AcceptanceStatus.DECLINED) {
      return 'Declined';
    } else if (status == AcceptanceStatus.PENDING) {
      return 'Pending';
    }
    return '';
  }

  static String stringFromGroupRole(GroupRole role) {
    switch (role) {
      case (GroupRole.Manager):
        return 'Manager';
      case (GroupRole.Supervisor):
        return 'Supervisor';
      default:
        return '';
    }
  }

  static GroupRole groupRoleFromString(String role) {
    role = role.toLowerCase();
    switch (role) {
      case ('manager'):
        return GroupRole.Manager;
      case ('supervisor'):
        return GroupRole.Supervisor;
      default:
        return null;
    }
  }

  static String stringFromOrgRole(Roles role, {bool forApi = false}) {
    switch (role) {
      case (Roles.OWNER):
        return 'Owner';
      case (Roles.ADMIN):
        return 'Admin';
      case (Roles.GROUP_MEMBER):
        return forApi ? 'GROUP_USER' : 'Group Member';
      default:
        return '';
    }
  }

  static CheckStatus checkStatusFromString(String string) {
    string = string.toUpperCase();
    switch (string) {
      case ('CONFIRMED'):
        return CheckStatus.Confirmed;
      default:
        return null;
    }
  }
}

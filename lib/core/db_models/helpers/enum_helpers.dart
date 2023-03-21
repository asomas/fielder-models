import 'package:fielder_models/core/constants/app_colors.dart';
import 'package:fielder_models/core/constants/app_strings.dart';
import 'package:fielder_models/core/db_models/old/schema/company_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/education_approval_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/job_template_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/offers_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/schedule_shift_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/staff_status_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/worker_account_deletion_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/worker_checks_schema.dart';
import 'package:fielder_models/core/db_models/temp/common.dart';
import 'package:fielder_models/core/db_models/worker/schema/newsNotificationSchema.dart';
import 'package:fielder_models/core/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_to_words/number_to_words.dart';

import '../../enums/slot_status_enums.dart';

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
      case OffersStatusUIString.invitedForInterview:
        return OfferStatus.InvitedForInterview;
      case OffersStatusUIString.interviewScheduled:
        return OfferStatus.InterviewScheduled;
      case OffersStatusUIString.workerResponded:
        return OfferStatus.WorkerResponded;
      default:
        return OfferStatus.None;
    }
  }

  static _enumToUIString(String str) {
    return toBeginningOfSentenceCase(str.replaceAll("_", ' ')?.toLowerCase());
  }

  static String getUIStringFromOfferStatus(OfferStatus status,
      {groupPending = false, isInvite = false}) {
    if (groupPending)
      switch (status) {
        case OfferStatus.InvitedForInterview:
          return OffersStatusUIString.invitedForInterview;
        case OfferStatus.InterviewScheduled:
          return OffersStatusUIString.interviewScheduled;
        case OfferStatus.PendingWorkerResponse:
        case OfferStatus.PendingChecksWorker:
        case OfferStatus.PendingChecksBackOffice:
        case OfferStatus.PendingWorkerFinalConfirmation:
          return isInvite
              ? OffersStatusUIString.pendingInvite
              : OffersStatusUIString.pendingOffer;
        case OfferStatus.WorkerResponded:
          return OffersStatusUIString.workerResponded;
        case OfferStatus.Accepted:
          return OffersStatusUIString.accepted;
        case OfferStatus.Declined:
          return OffersStatusUIString.declined;
        case OfferStatus.Retracted:
          return OffersStatusUIString.retracted;
        default:
          return '';
      }
    switch (status) {
      case OfferStatus.InvitedForInterview:
        return OffersStatusUIString.invitedForInterview;
      case OfferStatus.InterviewScheduled:
        return OffersStatusUIString.interviewScheduled;
      case OfferStatus.PendingWorkerResponse:
        return isInvite
            ? OffersStatusUIString.pendingWorkerResponse
            : OffersStatusUIString.pendingOffer;
      case OfferStatus.PendingChecksWorker:
        return OffersStatusUIString.pendingChecksWorker;
      case OfferStatus.PendingChecksBackOffice:
        return OffersStatusUIString.pendingChecksBackoffice;
      case OfferStatus.PendingWorkerFinalConfirmation:
        return OffersStatusUIString.pendingWorkerFinalConfirmation;
      case OfferStatus.WorkerResponded:
        return OffersStatusUIString.workerResponded;
      case OfferStatus.Accepted:
        return OffersStatusUIString.accepted;
      case OfferStatus.Declined:
        return OffersStatusUIString.declined;
      case OfferStatus.Retracted:
        return OffersStatusUIString.retracted;
      default:
        return '';
    }
  }

  static String getStringFromOfferStatus(OfferStatus status,
      {bool forUI = false}) {
    switch (status) {
      case OfferStatus.PendingChecksBackOffice:
        String str = OffersStatusString.pendingChecksBackoffice;
        return forUI ? _enumToUIString(str) : str;
      case OfferStatus.PendingChecksWorker:
        String str = OffersStatusString.pendingChecksWorker;
        return forUI ? _enumToUIString(str) : str;
      case OfferStatus.PendingWorkerFinalConfirmation:
        String str = OffersStatusString.pendingWorkerFinalConfirmation;
        return forUI ? _enumToUIString(str) : str;
      case OfferStatus.PendingWorkerResponse:
        String str = OffersStatusString.pendingWorkerResponse;
        return forUI ? _enumToUIString(str) : str;
      case OfferStatus.Queued:
        String str = OffersStatusString.queued;
        return forUI ? _enumToUIString(str) : str;
      case OfferStatus.Accepted:
        String str = OffersStatusString.accepted;
        return forUI ? _enumToUIString(str) : str;
      case OfferStatus.Declined:
        String str = OffersStatusString.declined;
        return forUI ? _enumToUIString(str) : str;
      case OfferStatus.Retracted:
        String str = OffersStatusString.retracted;
        return forUI ? _enumToUIString(str) : str;
      case OfferStatus.Expired:
        String str = OffersStatusString.expired;
        return forUI ? _enumToUIString(str) : str;
      default:
        String str = OffersStatusString.none;
        return forUI ? _enumToUIString(str) : str;
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
    bool forApi = false,
  }) {
    switch (shiftPatternFrequency) {
      case ShiftFrequencies.Daily:
        return 'Daily';
      case ShiftFrequencies.None:
        return 'Does not repeat';
      case ShiftFrequencies.Weekly:
        return forApi ? 'Weekly' : 'Custom';
      case ShiftFrequencies.TwoWeeks:
        return forApi ? 'Weekly' : 'Every two weeks';
      case ShiftFrequencies.Weekdays:
        return forApi ? 'Weekly' : 'Week days (Mon-Fri)';
      case ShiftFrequencies.Weekends:
        return forApi ? 'Weekly' : 'Weekends (Sat-Sun)';
      case ShiftFrequencies.CustomDay:
        return forApi ? 'Weekly' : 'Every ';
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

  // static InviteStaffStatus inviteStaffStatusFromString(String status) {
  //   switch (status) {
  //     case 'Pending':
  //       return InviteStaffStatus.Pending;
  //     case 'Declined':
  //       return InviteStaffStatus.Declined;
  //     case 'Accepted':
  //       return InviteStaffStatus.Accepted;
  //     default:
  //       return InviteStaffStatus.None;
  //   }
  // }

  // static String stringFromInviteStaffStatus(InviteStaffStatus status) {
  //   switch (status) {
  //     case InviteStaffStatus.Pending:
  //       return 'Pending';
  //     case InviteStaffStatus.Declined:
  //       return 'Declined';
  //     case InviteStaffStatus.Accepted:
  //       return 'Accepted';
  //     default:
  //       return null;
  //   }
  // }

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

  // static InviteStaffStatus offerStatusToInviteStatus(OfferStatus status) {
  //   switch (status) {
  //     case OfferStatus.None:
  //       return InviteStaffStatus.None;
  //     case OfferStatus.Declined:
  //       return InviteStaffStatus.Declined;
  //     case OfferStatus.Accepted:
  //       return InviteStaffStatus.Accepted;
  //     default:
  //       return InviteStaffStatus.Pending;
  //   }
  // }

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

  static CheckTypeFromValue getCheckTypeFromValueFromString(String value) {
    if (value != null) {
      if (value
                  ?.toUpperCase()
                  ?.startsWith(WorkerChecksSchema.dbsValue.toUpperCase()) ==
              true ||
          value.startsWith(WorkerChecksSchema.dbsId)) {
        return CheckTypeFromValue.DBS;
      } else if (value
              .toUpperCase()
              .startsWith(WorkerChecksSchema.enhancedDbsValue.toUpperCase()) ||
          value.toUpperCase().startsWith('ENHANCED_DBS') ||
          value.startsWith(WorkerChecksSchema.enhancedDbsId)) {
        return CheckTypeFromValue.EnhancedDBS;
      } else if (value
              .toUpperCase()
              .startsWith(WorkerChecksSchema.proofOfIDValue.toUpperCase()) ||
          value.startsWith(WorkerChecksSchema.proofOfIdId)) {
        return CheckTypeFromValue.ProofOfID;
      } else if (value.toUpperCase().startsWith(
              WorkerChecksSchema.proofOfAddressValue.toUpperCase()) ||
          value.startsWith(WorkerChecksSchema.proofOfAddressId)) {
        return CheckTypeFromValue.ProofOfAddress;
      } else if (value.toUpperCase().startsWith(
              WorkerChecksSchema.experiencedReferencedValue.toUpperCase()) ||
          value.startsWith(WorkerChecksSchema.experiencedReferencedId)) {
        return CheckTypeFromValue.ExperiencesReferenced;
      } else if (value.toUpperCase().startsWith(
              WorkerChecksSchema.fiveYearWorkHistoryValue.toUpperCase()) ||
          value.startsWith(WorkerChecksSchema.fiveYearWorkHistoryId)) {
        return CheckTypeFromValue.WorkHistory;
      } else if (value
              .toUpperCase()
              .startsWith(WorkerChecksSchema.RTWValue.toUpperCase()) ||
          value.startsWith(WorkerChecksSchema.RTWId)) {
        return CheckTypeFromValue.RightToWork;
      } else if (value
              .toUpperCase()
              .startsWith(WorkerChecksSchema.onBoardingValue.toUpperCase()) ||
          value.startsWith(WorkerChecksSchema.onBoardingId)) {
        return CheckTypeFromValue.OnBoarding;
      } else if (value
              .toUpperCase()
              .startsWith(WorkerChecksSchema.approvedGapsValue.toUpperCase()) ||
          value.startsWith(WorkerChecksSchema.approvedGapsId)) {
        return CheckTypeFromValue.ApprovedGaps;
      } else {
        return null;
      }
    }
    return null;
  }

  static CheckType getCheckTypeFromString(String value) {
    if (value != null) {
      if (value?.toUpperCase()?.startsWith('ORG_SPECIFIC'.toUpperCase()) ==
          true) {
        return CheckType.OrgSpecific;
      } else {
        return CheckType.Global;
      }
    }
    return null;
  }

  static String getStringFromCheckType(CheckTypeFromValue value) {
    if (value != null) {
      switch (value) {
        case (CheckTypeFromValue.DBS):
          return 'DBS';
        case (CheckTypeFromValue.EnhancedDBS):
          return 'ENHANCED_DBS';
        default:
          return null;
      }
    }
    return null;
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
    role = role?.toLowerCase();
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
    status = status?.toLowerCase();
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
    role = role?.toLowerCase();
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
    string = string?.toUpperCase();
    switch (string) {
      case ('CONFIRMED'):
        return CheckStatus.Confirmed;
      case ('INVALIDATED'):
        return CheckStatus.Invalidated;
      case ('AWAITING_BACKOFFICE'):
        return CheckStatus.AwaitingBackOffice;
      default:
        return null;
    }
  }

  static String stringFromCheckStatus(CheckStatus status) {
    switch (status) {
      case (CheckStatus.Confirmed):
        return 'CONFIRMED';
      case (CheckStatus.Invalidated):
        return 'INVALIDATED';
      case (CheckStatus.AwaitingBackOffice):
        return 'AWAITING_BACKOFFICE';
      case (CheckStatus.NotStarted):
        return 'NOT_STARTED';
      default:
        return null;
    }
  }

  static String stringFromOnBoardingDocumentSignedStatus(
      OnBoardingDocumentSignStatus status) {
    switch (status) {
      case (OnBoardingDocumentSignStatus.Signed):
        return 'Signed';
      default:
        return 'Unsigned';
    }
  }

  static OnBoardingDocumentSignStatus onBoardingDocumentSignStatusFromString(
      String string) {
    string = string?.toLowerCase();
    switch (string) {
      case ('signed'):
        return OnBoardingDocumentSignStatus.Signed;
      default:
        return OnBoardingDocumentSignStatus.Unsigned;
    }
  }

  static String stringFromSlotStatusIcon(SlotStatusIcon slotStatusIcon,
      {bool fromInterview = false}) {
    switch (slotStatusIcon) {
      case (SlotStatusIcon.RecurringActive):
      case (SlotStatusIcon.RecurringInactive):
        return "Recurring Shift";
      case (SlotStatusIcon.Active):
        return fromInterview ? "Assigned Interview" : "Assigned Shift";
      case (SlotStatusIcon.Inactive):
        return fromInterview ? "Unassigned Interview" : "Unassigned Shift";
      case (SlotStatusIcon.Missed):
        return "Missed Shift";
      case (SlotStatusIcon.Late):
        return "Missed Shift";
        break;
      case (SlotStatusIcon.ClockedInLate):
        return "Clocked In Late";
      case (SlotStatusIcon.ClockedIn):
        return "Clocked In";
      case (SlotStatusIcon.ClockedOutLate):
        return "Clocked Out Late";
      case (SlotStatusIcon.ClockedOut):
      case (SlotStatusIcon.ClockedOutEarly):
        return "Clocked Out";
      case (SlotStatusIcon.NotClockedOut):
        return "Not Clocked Out";
      case (SlotStatusIcon.Approved):
        return "Approved";
      default:
        return fromInterview ? "Interview" : "Shift";
    }
  }

  static Trending trendingFromString(String string) {
    string = string?.toLowerCase();
    switch (string) {
      case ('up'):
        return Trending.Up;
      default:
        return Trending.Down;
    }
  }

  static String stringFromTrending(Trending trending) {
    switch (trending) {
      case (Trending.Up):
        return "Up";
      default:
        return "Down";
    }
  }

  static EducationApprovalStatus statusFromEducationApprovalString(String str) {
    str = str?.toUpperCase();
    switch (str) {
      case (EducationApprovalSchema.signed):
        return EducationApprovalStatus.Signed;
      default:
        return EducationApprovalStatus.Unsigned;
    }
  }

  static NewsCardAction newsCardActionFromString(String str) {
    switch (str?.toUpperCase()) {
      case NewsNotificationSchema.postRequest:
        return NewsCardAction.PostRequest;
      case NewsNotificationSchema.getRequest:
        return NewsCardAction.GetRequest;
      case NewsNotificationSchema.browser:
        return NewsCardAction.Browser;
      case NewsNotificationSchema.navigateScreen:
        return NewsCardAction.NavigateScreen;
      default:
        return null;
    }
  }

  static String stringFromReasonForLeaving(
      ReasonForLeavingApp reasonForLeavingApp) {
    switch (reasonForLeavingApp) {
      case (ReasonForLeavingApp.AppConfusing):
        return WorkerAccountDeletionSchema.appConfusing;
      case (ReasonForLeavingApp.FoundOtherWork):
        return WorkerAccountDeletionSchema.foundOtherWork;
      case (ReasonForLeavingApp.NotHappySupport):
        return WorkerAccountDeletionSchema.notHappySupport;
      case (ReasonForLeavingApp.AppNotTrustworthy):
        return WorkerAccountDeletionSchema.appNotTrustWorthy;
      case (ReasonForLeavingApp.NotOfferedJob):
        return WorkerAccountDeletionSchema.notOfferedJob;
      case (ReasonForLeavingApp.Other):
        return WorkerAccountDeletionSchema.other;
      default:
        return "";
    }
  }

  static String descriptionFromReasonForLeaving(
      ReasonForLeavingApp reasonForLeavingApp) {
    switch (reasonForLeavingApp) {
      case (ReasonForLeavingApp.AppConfusing):
        return WorkerAccountDeletionSchema.appConfusingDesc;
      case (ReasonForLeavingApp.FoundOtherWork):
        return WorkerAccountDeletionSchema.foundOtherWorkDesc;
      case (ReasonForLeavingApp.NotHappySupport):
        return WorkerAccountDeletionSchema.notHappySupportDesc;
      case (ReasonForLeavingApp.AppNotTrustworthy):
        return WorkerAccountDeletionSchema.appNotTrustWorthyDesc;
      case (ReasonForLeavingApp.NotOfferedJob):
        return WorkerAccountDeletionSchema.notOfferedJobDesc;
      case (ReasonForLeavingApp.Other):
        return WorkerAccountDeletionSchema.otherDesc;
      default:
        return "";
    }
  }

  static SkillPriority skillPriorityFromInt(int important) {
    switch (important) {
      case (1):
        return SkillPriority.important;
      case (0):
        return SkillPriority.desirable;
      default:
        return SkillPriority.none;
    }
  }

  static int intFromSkillPriority(SkillPriority priority) {
    switch (priority) {
      case (SkillPriority.important):
        return 1;
      case (SkillPriority.desirable):
        return 0;
      default:
        return 0;
    }
  }

  static BudgetServiceType budgetTypeFromString(String type) {
    switch (type) {
      case BudgetSchema.umbrella:
        return BudgetServiceType.FielderPayroll;
      case BudgetSchema.staffing:
        return BudgetServiceType.FielderHire;
      default:
        return null;
    }
  }

  static String stringFromBudgetType(BudgetServiceType type) {
    switch (type) {
      case BudgetServiceType.FielderPayroll:
        return BudgetSchema.umbrella;
      case BudgetServiceType.FielderHire:
        return BudgetSchema.staffing;
      default:
        return "";
    }
  }

  static String stringFromBudgetTypeUI(BudgetServiceType type) {
    switch (type) {
      case BudgetServiceType.FielderPayroll:
        return BudgetSchema.fielderPayroll;
      case BudgetServiceType.FielderHire:
        return BudgetSchema.fielderHire;
      default:
        return "";
    }
  }
}

import 'package:fielder_models/core/constants/app_colors.dart';
import 'package:fielder_models/core/constants/app_strings.dart';
import 'package:fielder_models/core/enums/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class EnumHelpers {

  static OfferStatus getOfferStatusFromString(String status) {
    switch (status) {
      case 'Pending':
        return OfferStatus.Pending;
      case 'Declined':
        return OfferStatus.Rejected;
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
        return 'None';
      case ShiftFrequencies.Weekly:
        return 'Weekly';
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
}

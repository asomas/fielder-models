import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/old/address_model.dart';
import 'package:fielder_models/core/db_models/old/schema/job_summary_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/job_template_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/payment_model_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/shift_pattern_data_schema.dart';
import 'package:fielder_models/core/enums/enums.dart';

class BudgetModel {
  CalculatePay payCalculation;
  int lateArrival;
  int earlyLeaver;
  double overTimeRate;
  bool volunteer;
  PaymentModel paymentModel;
  bool enableEarlyDeduction;
  bool enableLateDeduction;
  int overTimeThreshHold;
  bool enableUnpaidBreaks;
  String id;
  String name;
  DocumentReference organisationRef;
  DocumentReference groupRef;
  DocumentReference jobTemplateRef;
  AddressModel addressModel;
  BudgetServiceType budgetType;

  BudgetModel({
    this.payCalculation = CalculatePay.ShiftHours,
    this.lateArrival = 0,
    this.earlyLeaver = 0,
    this.overTimeRate,
    this.volunteer = false,
    this.enableLateDeduction = false,
    this.enableEarlyDeduction = false,
    this.paymentModel,
    this.overTimeThreshHold,
    this.enableUnpaidBreaks = false,
    this.id,
    this.name,
    this.groupRef,
    this.jobTemplateRef,
    this.addressModel,
    this.budgetType,
    this.organisationRef,
  });

  factory BudgetModel.fromMap(Map data, {String id}) {
    try {
      String budgetId = id;
      if (data != null &&
          data.containsKey(JobTemplateSchema.budgetRef) &&
          data[JobTemplateSchema.budgetRef] != null) {
        budgetId = (data[JobTemplateSchema.budgetRef] as DocumentReference)?.id;
      }
      return BudgetModel(
        volunteer: data[JobTemplateSchema.volunteer] ?? false,
        payCalculation: data[JobTemplateSchema.payCalculation] != null
            ? EnumHelpers.getPayTypeFromString(
                data[JobTemplateSchema.payCalculation])
            : null,
        lateArrival: data[JobTemplateSchema.lateArrival] ?? 0,
        earlyLeaver: data[JobTemplateSchema.earlyLeaver] ?? 0,
        overTimeRate: data[JobTemplateSchema.overtimeRate] != null
            ? (data[JobTemplateSchema.overtimeRate] / PaymentModel.onePence)
                .toDouble()
            : 0,
        enableEarlyDeduction:
            data[JobTemplateSchema.enableEarlyDeduction] ?? false,
        enableLateDeduction:
            data[JobTemplateSchema.enableLateDeduction] ?? false,
        overTimeThreshHold: data[JobSummarySchema.overtimeThreshold],
        paymentModel: data[JobTemplateSchema.payment] != null
            ? PaymentModel.fromMap(data[JobTemplateSchema.payment])
            : null,
        enableUnpaidBreaks: data[JobSummarySchema.enableUnpaidBreaks],
        id: budgetId,
        name:
            data[JobTemplateSchema.name] ?? data[JobTemplateSchema.budgetName],
        groupRef: data[JobTemplateSchema.groupRef],
        jobTemplateRef: data[JobTemplateSchema.jobTemplateRef],
        addressModel: data[BudgetSchema.locationData] != null
            ? AddressModel.fromMap(
                map: data[BudgetSchema.locationData][JobTemplateSchema.address])
            : null,
        budgetType: data[BudgetSchema.selectedService] != null
            ? EnumHelpers.budgetTypeFromString(
                data[BudgetSchema.selectedService])
            : null,
        organisationRef: data[JobTemplateSchema.organisationRef],
      );
    } catch (e, s) {
      print("Budget Model catch_____${e}____$s");
      return null;
    }
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> _map = {};
    try {
      _map = {
        JobTemplateSchema.volunteer: volunteer ?? false,
        JobTemplateSchema.payment:
            PaymentModel(totalCost: paymentModel?.totalCost)
                .paymentMapForCreateJob(),
        JobTemplateSchema.payCalculation:
            EnumHelpers.getStringForPayType(payCalculation),
        JobTemplateSchema.lateArrival: lateArrival,
        JobTemplateSchema.earlyLeaver: earlyLeaver,
        JobTemplateSchema.overtimeRate: overTimeRate != null
            ? convertRateToPence(overTimeRate.toString())
            : 0,
        JobTemplateSchema.enableEarlyDeduction: enableEarlyDeduction,
        JobTemplateSchema.enableLateDeduction: enableLateDeduction,
        JobSummarySchema.overtimeThreshold: overTimeThreshHold,
        JobSummarySchema.enableUnpaidBreaks: enableUnpaidBreaks,
        BudgetSchema.selectedService:
            EnumHelpers.stringFromBudgetType(budgetType),
      };
      // if (volunteer) {
      //   _map.remove(JobTemplateSchema.payment);
      // }
      if (payCalculation == CalculatePay.ClockedInHours) {
        _map.remove(JobTemplateSchema.enableLateDeduction);
        _map.remove(JobTemplateSchema.enableEarlyDeduction);
      }
      if (name != null && name.isNotEmpty) {
        _map[JobTemplateSchema.name] = name;
      }
      if (jobTemplateRef != null) {
        _map[JobTemplateSchema.jobTemplateRef] = "${jobTemplateRef.path}";
      }
      if (addressModel != null) {
        _map[BudgetSchema.locationData] = {
          ShiftDataSchema.address: addressModel.toJSON(),
        };
      }

      if (paymentModel.totalCost != null) {
        _map[PaymentModelSchema.totalCost] = paymentModel?.totalCost;
      } else if (paymentModel.workerRate == null) {
        _map[PaymentModelSchema.workerRate] = paymentModel?.workerRate;
      }

      print("Budget Model map -> $_map");
    } catch (e) {
      print('Budget Model toJSON error: $e');
    }
    return _map;
  }

  static int convertRateToPence(String rate) {
    if (rate != null && rate.isNotEmpty) {
      return (double.parse(rate) * PaymentModel.onePence).round();
    }
    return 0;
  }
}

class PaymentModel {
  double fielderMargin;
  double fielderDiscount;
  double totalCost;
  double discountCost;
  double workerRate;
  double statuaryCost;
  double holidayPay;

  static const double onePence = 100.0;

  PaymentModel(
      {this.fielderMargin,
      this.fielderDiscount,
      this.totalCost,
      this.discountCost,
      this.workerRate,
      this.statuaryCost,
      this.holidayPay});

  factory PaymentModel.fromMap(Map map) {
    try {
      double _fielderMargin = (map[PaymentModelSchema.umbrellaFee] +
              map[PaymentModelSchema.findersFee]) /
          onePence;
      double _fielderDiscount = map[PaymentModelSchema.findersFee] / onePence;
      double _totalCost =
          map[PaymentModelSchema.totalStaffingServiceCost] / onePence;
      double _discountCost =
          map[PaymentModelSchema.totalUmbrellaServiceCost] / onePence;
      double _workerRate = map[PaymentModelSchema.workerRate] / onePence;
      double _holidayPay = map[PaymentModelSchema.holidayPay] / onePence;
      double _statuaryCost = 0;
      if (map[PaymentModelSchema.statutaryCosts] != null) {
        _statuaryCost = map[PaymentModelSchema.statutaryCosts]
                [PaymentModelSchema.total] /
            onePence;
      }
      return PaymentModel(
          workerRate: _workerRate,
          fielderDiscount: _fielderDiscount,
          fielderMargin: _fielderMargin,
          totalCost: _totalCost,
          discountCost: _discountCost,
          holidayPay: _holidayPay,
          statuaryCost: _statuaryCost);
    } catch (e, s) {
      print("payment model catch_____${e}_____$s");
      return null;
    }
  }

  Map paymentMapForCreateJob() {
    if (totalCost != null) {
      return {
        PaymentModelSchema.totalStaffingServiceCost:
            (totalCost * onePence).round()
      };
    }
    return {};
  }
}

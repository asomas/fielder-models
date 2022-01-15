import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/old/schema/job_summary_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/job_template_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/payment_model_schema.dart';
import 'package:fielder_models/core/enums/enums.dart';

class BudgetModel {
  CalculatePay payCalculation;
  int lateArrival;
  int earlyLeaver;
  int overTimeRate;
  bool volunteer;
  PaymentModel paymentModel;
  bool enableEarlyDeduction;
  bool enableLateDeduction;
  int overTimeThreshHold;
  bool enableUnpaidBreaks;

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
  });

  factory BudgetModel.fromMap(Map data) {
    try {
      return BudgetModel(
        volunteer: data[JobTemplateSchema.volunteer] ?? false,
        payCalculation: data[JobTemplateSchema.payCalculation] != null
            ? EnumHelpers.getPayTypeFromString(
                data[JobTemplateSchema.payCalculation])
            : null,
        lateArrival: data[JobTemplateSchema.lateArrival] ?? 0,
        earlyLeaver: data[JobTemplateSchema.earlyLeaver] ?? 0,
        overTimeRate: data[JobTemplateSchema.overtimeRate] != null
            ? data[JobTemplateSchema.overtimeRate] / PaymentModel.onePence
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
        JobTemplateSchema.overtimeRate: overTimeRate,
        JobTemplateSchema.enableEarlyDeduction: enableEarlyDeduction,
        JobTemplateSchema.enableLateDeduction: enableLateDeduction,
        JobSummarySchema.overtimeThreshold: overTimeThreshHold,
        JobSummarySchema.enableUnpaidBreaks: enableUnpaidBreaks,
      };
      // if (volunteer) {
      //   _map.remove(JobTemplateSchema.payment);
      // }
      if (payCalculation == CalculatePay.ClockedInHours) {
        _map.remove(JobTemplateSchema.enableLateDeduction);
        _map.remove(JobTemplateSchema.enableEarlyDeduction);
      }
      print("Budget Model map -> $_map");
    } catch (e) {
      print('Budget Model toJSON error: $e');
    }
    return _map;
  }

  static int convertRateToPence(String rate) {
    if (rate != null && rate.isNotEmpty) {
      return (double.parse(rate) * PaymentModel.onePence).toInt();
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

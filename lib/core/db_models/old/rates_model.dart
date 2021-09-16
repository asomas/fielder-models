import 'package:fielder_models/core/db_models/old/schema/indeed_rates_schema.dart';

class RatesModel {
  SalaryAndCurrency minSalary;
  SalaryAndCurrency maxSalary;
  SalaryAndCurrency localAverageSalary;
  SalaryAndCurrency nationalAverageSalary;

  RatesModel(
      {this.minSalary,
      this.maxSalary,
      this.localAverageSalary,
      this.nationalAverageSalary});

  factory RatesModel.fromMap(Map map) {
    try {
      return RatesModel(
        minSalary: SalaryAndCurrency.fromMap(map[RatesSchema.localMinSalary]),
        maxSalary: SalaryAndCurrency.fromMap(map[RatesSchema.localMaxSalary]),
        localAverageSalary:
            SalaryAndCurrency.fromMap(map[RatesSchema.localMedianSalary]),
        nationalAverageSalary:
            SalaryAndCurrency.fromMap(map[RatesSchema.nationalMedianSalary]),
      );
    } catch (e, s) {
      print('rates model catch $e, $s');
      return null;
    }
  }
}

class SalaryAndCurrency {
  double salary;
  String currency;

  SalaryAndCurrency({this.salary, this.currency});

  factory SalaryAndCurrency.fromMap(Map map) {
    try {
      return SalaryAndCurrency(
        salary: map[RatesSchema.salary],
        currency: map[RatesSchema.currency],
      );
    } catch (e, s) {
      print('rates and currency model catch $e, $s');
      return null;
    }
  }
}

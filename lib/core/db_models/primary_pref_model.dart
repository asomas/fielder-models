
import 'package:fielder_models/core/db_models/schema/employer_schema.dart';

class PrimaryPrefModel {
  String email;
  String name;
  String preferredNumber;
  String secondaryNumber;

  PrimaryPrefModel();

  PrimaryPrefModel.fromJson(Map<String, dynamic> json)
      : email = json[EmployerSchema.email],
        name = json[EmployerSchema.name],
        preferredNumber = json[EmployerSchema.preferredNumber],
        secondaryNumber = json[EmployerSchema.secondaryNumber];

  Map<String, dynamic> toJson() => {
    EmployerSchema.email: email,
    EmployerSchema.name: name,
    EmployerSchema.preferredNumber: preferredNumber,
    EmployerSchema.secondaryNumber: secondaryNumber,
  };
}
import 'package:fielder_models/core/db_models/old/schema/employer_schema.dart';

class AlternativePrefModel {
  String email;
  String name;
  String preferredNumber;
  String secondaryNumber;

  AlternativePrefModel();

  AlternativePrefModel.fromJson(Map<String, dynamic> json)
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
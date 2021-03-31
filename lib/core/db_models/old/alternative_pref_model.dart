import 'package:fielder_models/core/db_models/old/schema/organisation_schema.dart';

class AlternativePrefModel {
  String email;
  String name;
  String preferredNumber;
  String secondaryNumber;

  AlternativePrefModel();

  AlternativePrefModel.fromJson(Map<String, dynamic> json)
      : email = json[OrganisationSchema.email],
        name = json[OrganisationSchema.company_name],
        preferredNumber = json[OrganisationSchema.preferredNumber],
        secondaryNumber = json[OrganisationSchema.secondaryNumber];

  Map<String, dynamic> toJson() => {
    OrganisationSchema.email: email,
    OrganisationSchema.company_name: name,
    OrganisationSchema.preferredNumber: preferredNumber,
    OrganisationSchema.secondaryNumber: secondaryNumber,
  };
}
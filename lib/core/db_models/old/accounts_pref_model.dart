import 'package:fielder_models/core/db_models/old/schema/organisation_schema.dart';

class AccountsPrefModel {
  String email;
  String name;
  String preferredNumber;
  String secondaryNumber;

  AccountsPrefModel();

  AccountsPrefModel.fromJson(Map<String, dynamic> json)
      : email = json[OrganisationSchema.email],
        name = json[OrganisationSchema.name],
        preferredNumber = json[OrganisationSchema.preferredNumber],
        secondaryNumber = json[OrganisationSchema.secondaryNumber];

  Map<String, dynamic> toJson() => {
    OrganisationSchema.email: email,
    OrganisationSchema.name: name,
    OrganisationSchema.preferredNumber: preferredNumber,
    OrganisationSchema.secondaryNumber: secondaryNumber,
  };
}
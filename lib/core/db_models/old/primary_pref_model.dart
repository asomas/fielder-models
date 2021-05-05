import 'package:fielder_models/core/db_models/old/schema/organisation_schema.dart';

class PrimaryPrefModel {
  String email;
  String name;
  String preferredNumber;
  String secondaryNumber;

  PrimaryPrefModel();

  PrimaryPrefModel.fromJson(Map<String, dynamic> json)
      : email = json[OrganisationSchema.email],
        name = json[OrganisationSchema.companyName],
        preferredNumber = json[OrganisationSchema.preferredNumber],
        secondaryNumber = json[OrganisationSchema.secondaryNumber];

  Map<String, dynamic> toJson() => {
        OrganisationSchema.email: email,
        OrganisationSchema.companyName: name,
        OrganisationSchema.preferredNumber: preferredNumber,
        OrganisationSchema.secondaryNumber: secondaryNumber,
      };
}

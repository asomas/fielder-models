import 'package:fielder_models/core/db_models/worker/schema/supportVideoOrganisationSchema.dart';

class SupportVideoOrganisation {
  SupportVideoOrganisation({
    this.jobSummary,
    this.staffSummary,
    this.notificationsSummary,
    this.createShift,
    this.assignShift,
    this.getHelp,
  });

  String jobSummary;
  String staffSummary;
  String notificationsSummary;
  String createShift;
  String assignShift;
  String getHelp;

  factory SupportVideoOrganisation.fromJson(Map<String, dynamic> json) =>
      SupportVideoOrganisation(
          jobSummary: json[SupportVideoOrganisationSchema.jobSummary] ?? "",
          staffSummary: json[SupportVideoOrganisationSchema.staffSummary] ?? "",
          notificationsSummary:
              json[SupportVideoOrganisationSchema.notificationsSummary] ?? "",
          assignShift: json[SupportVideoOrganisationSchema.assignShift] ?? "",
          createShift: json[SupportVideoOrganisationSchema.createShift] ?? "",
          getHelp: json[SupportVideoOrganisationSchema.getHelp] ?? "");
}

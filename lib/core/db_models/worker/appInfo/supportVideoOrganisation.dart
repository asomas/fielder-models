import 'package:fielder_models/core/db_models/worker/schema/supportVideoOrganisationSchema.dart';

class SupportVideoOrganisation{
  SupportVideoOrganisation({
    this.jobSummary,
    this.staffSummary,
    this.notificationsSummary
  });

  String jobSummary;
  String staffSummary;
  String notificationsSummary;


  factory SupportVideoOrganisation.fromJson(Map<String, dynamic> json) => SupportVideoOrganisation(
    jobSummary: json[SupportVideoOrganisationSchema.jobSummary]??"",
    staffSummary: json[SupportVideoOrganisationSchema.staffSummary]??"",
    notificationsSummary: json[SupportVideoOrganisationSchema.notificationsSummary]??"",
  );
}
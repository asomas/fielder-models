import 'package:fielder_models/core/db_models/worker/schema/supportVideoOrganisationSchema.dart';

import '../../../enums/enums.dart';

class SupportVideoOrganisation {
  SupportVideoOrganisation({
    this.jobSummary,
    this.staffSummary,
    this.notificationsSummary,
    this.createShift,
    this.assignShift,
    this.getHelp,
    this.organisationSetup,
  });

  String jobSummary;
  String staffSummary;
  String notificationsSummary;
  String createShift;
  String assignShift;
  String getHelp;
  String organisationSetup;

  factory SupportVideoOrganisation.fromJson(Map<String, dynamic> json) =>
      SupportVideoOrganisation(
        jobSummary: json[SupportVideoOrganisationSchema.jobSummary] ?? "",
        staffSummary: json[SupportVideoOrganisationSchema.staffSummary] ?? "",
        notificationsSummary:
            json[SupportVideoOrganisationSchema.notificationsSummary] ?? "",
        assignShift: json[SupportVideoOrganisationSchema.assignShift] ?? "",
        createShift: json[SupportVideoOrganisationSchema.createShift] ?? "",
        getHelp: json[SupportVideoOrganisationSchema.getHelp] ?? "",
        organisationSetup:
            json[SupportVideoOrganisationSchema.organisation_setup] ?? "",
      );

  String urlFromEnum(SupportVideosEnums enums) {
    switch (enums) {
      case SupportVideosEnums.AssignShift:
        return assignShift;
      case SupportVideosEnums.JobSummary:
        return jobSummary;
      case SupportVideosEnums.NotificationsSummary:
        return notificationsSummary;
      case SupportVideosEnums.CreateShift:
        return createShift;
      case SupportVideosEnums.GetHelp:
        return getHelp;
      case SupportVideosEnums.OrganisationSetup:
        return organisationSetup;
      default:
        return null;
    }
  }
}

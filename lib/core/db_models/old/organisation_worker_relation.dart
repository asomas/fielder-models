import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/helpers/helpers.dart';
import 'package:fielder_models/core/db_models/old/schema/company_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/organisation_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/organisation_worker_relation_schema.dart';
import 'package:fielder_models/core/enums/enums.dart';
import 'package:flutter/cupertino.dart';

class OrganisationWorkerRelation {
  String docId;
  String organisationID;
  String organisationGroupID;
  bool isStaff;
  String pictureUrl;
  String workerFirstName;
  String workerLastName;
  String phone;
  DateTime lastShiftsDate;
  String workerId;
  OrganisationModel organisationModel;
  String owrRefId;
  bool tempToPermRequested;

  OrganisationWorkerRelation({
    this.docId,
    this.organisationID,
    this.organisationGroupID,
    this.isStaff,
    this.pictureUrl,
    this.workerFirstName,
    this.workerLastName,
    this.phone,
    this.lastShiftsDate,
    this.workerId,
    this.organisationModel,
    this.owrRefId,
    this.tempToPermRequested,
  });

  factory OrganisationWorkerRelation.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map != null && map.isNotEmpty) {
      try {
        final DocumentReference _organisationIdRef =
            map[OrganisationWorkerRelationSchema.organisationRef];
        final DocumentReference _organisationGroupIdRef =
            map[OrganisationWorkerRelationSchema.organisationGroupRef];
        final bool _isStaff =
            map[OrganisationWorkerRelationSchema.isStaff] ?? false;
        final String _pictureURL =
            map[OrganisationWorkerRelationSchema.pictureUrl] ?? '';
        final String _firstName =
            map[OrganisationWorkerRelationSchema.workerFirstName] ?? '';
        final String _lastName =
            map[OrganisationWorkerRelationSchema.workerLastName] ?? '';
        final String _phone = map[OrganisationWorkerRelationSchema.phone] ?? '';
        final Timestamp _lastReviewTimeStamp =
            map[OrganisationWorkerRelationSchema.lastShiftDate];
        final DocumentReference _workerIdRef =
            map[OrganisationWorkerRelationSchema.workerRef];
        DateTime _lastReviewDate;
        if (_lastReviewTimeStamp != null) {
          _lastReviewDate = _lastReviewTimeStamp.toDate();
        }

        return OrganisationWorkerRelation(
            docId: docID,
            organisationID: _organisationIdRef?.id,
            organisationGroupID: _organisationGroupIdRef?.id,
            isStaff: _isStaff,
            pictureUrl: _pictureURL,
            workerFirstName: _firstName,
            workerLastName: _lastName,
            phone: _phone,
            lastShiftsDate: _lastReviewDate,
            workerId: _workerIdRef?.id,
            tempToPermRequested:
                map[OrganisationWorkerRelationSchema.tempToPermRequested] ??
                    false,
            organisationModel: OrganisationModel.fromMap(
                map[OrganisationWorkerRelationSchema.organisationData]),
            owrRefId: map[OrganisationWorkerRelationSchema.owrRefId]);
      } catch (e, s) {
        print(
            "organisation_worker_relation.dart_____Model Catch_________${e}___$s");
        return null;
      }
    }
    return null;
  }

  String getName() {
    return '${workerFirstName ?? ''} ${workerLastName ?? ''}';
  }
}

class OrganisationModel {
  Color brandColor;
  String companyName;
  String organisationReferenceId;
  OrganisationContractStatus contractsStatus;

  OrganisationModel(
      {this.brandColor,
      this.companyName,
      this.organisationReferenceId,
      this.contractsStatus});

  factory OrganisationModel.fromMap(Map map) {
    try {
      return OrganisationModel(
        brandColor: Helpers.hexToColor(map[OrganisationSchema.brandColor]),
        companyName: map[OrganisationSchema.companyName],
        organisationReferenceId: map[OrganisationSchema.organisationRefId],
        contractsStatus: EnumHelpers.contractStatusTypeFromString(
            map[CompanySchema.signupStatus]),
      );
    } catch (e, s) {
      print("organisation model catch_____${e}______$s");
      return null;
    }
  }
}

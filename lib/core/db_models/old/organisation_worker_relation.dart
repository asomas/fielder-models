import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/schema/organisation_worker_relation_schema.dart';
import 'package:flutter/cupertino.dart';

class OrganisationWorkerRelation {
  String docId;
  String organisationID;
  bool isStaff;
  String pictureUrl;
  String workerFirstName;
  String workerLastName;
  String phone;
  DateTime lastReview;
  String workerId;

  OrganisationWorkerRelation(
      {this.docId,
      this.organisationID,
      this.isStaff,
      this.pictureUrl,
      this.workerFirstName,
      this.workerLastName,
      this.phone,
      this.lastReview,
      this.workerId});

  factory OrganisationWorkerRelation.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      try {
        final DocumentReference _organisationIdRef =
            map[OrganisationWorkerRelationSchema.organisationRef];
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
          organisationID: _organisationIdRef.id,
          isStaff: _isStaff,
          pictureUrl: _pictureURL,
          workerFirstName: _firstName,
          workerLastName: _lastName,
          phone: _phone,
          lastReview: _lastReviewDate,
          workerId: _workerIdRef.id,
        );
      } catch (e) {
        print("organisation_worker_relation.dart_____Model Catch_________$e");
        return null;
      }
    }
    return null;
  }

  String getName() {
    return '${workerFirstName ?? ''} ${workerLastName ?? ''}';
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrganisationWorkerRelation {
  String organisationID;
  bool isStaff;
  String pictureUrl;
  String workerFirstName;
  String workerLastName;
  String phone;
  DateTime lastReview;
  String workerId;

  OrganisationWorkerRelation(
      {this.organisationID,
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
      try{
        final DocumentReference _organisationIdRef = map['organisation_ref'];
        final bool _isStaff = map['is_staff'] ?? false;
        final String _pictureURL = map['picture_url'] ?? '';
        final String _firstName = map['worker_first_name'] ?? '';
        final String _lastName = map['worker_last_name'] ?? '';
        final String _phone = map['phone'] ?? '';
        final Timestamp _lastReviewTimeStamp = map['last_shift_date'];
        final DocumentReference _workerIdRef = map['worker_ref'];
        DateTime _lastReviewDate;
        if(_lastReviewTimeStamp != null){
          _lastReviewDate = _lastReviewTimeStamp.toDate();
        }

        return OrganisationWorkerRelation(
            organisationID: _organisationIdRef.id,
            isStaff: _isStaff,
            pictureUrl: _pictureURL,
            workerFirstName: _firstName,
            workerLastName: _lastName,
            phone: _phone,
            lastReview: _lastReviewDate,
            workerId: _workerIdRef.id);
      }catch(e){
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

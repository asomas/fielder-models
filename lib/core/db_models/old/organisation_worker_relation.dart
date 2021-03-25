import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrganisationWorkerRelation {
  String organisationID;
  bool isStaff;
  String pictureUrl;
  String workerFirstName;
  String workerLastName;
  String phone;
  String workerId;

  OrganisationWorkerRelation(
      {this.organisationID,
      this.isStaff,
      this.pictureUrl,
      this.workerFirstName,
      this.workerLastName,
      this.phone,
      this.workerId});

  factory OrganisationWorkerRelation.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      final DocumentReference _organisationIdRef = map['organisation_ref'];
      final bool _isStaff = map['is_staff'] ?? false;
      final String _pictureURL = map['picture_url'] ?? '';
      final String _firstName = map['worker_first_name'] ?? '';
      final String _lastName = map['worker_last_name'] ?? '';
      final String _phone = map['phone'] ?? '';
      final DocumentReference _workerIdRef = map['worker_ref'];

      return OrganisationWorkerRelation(
          organisationID: _organisationIdRef.id,
          isStaff: _isStaff,
          pictureUrl: _pictureURL,
          workerFirstName: _firstName,
          workerLastName: _lastName,
          phone: _phone,
          workerId: _workerIdRef.id);
    }
    return null;
  }

  String getName() {
    return '${workerFirstName ?? ''} ${workerLastName ?? ''}';
  }
}

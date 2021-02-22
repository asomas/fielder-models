import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class EmployerWorkerRelation {
  String employerID;
  bool isStaff;
  String pictureUrl;
  String workerFirstName;
  String workerLastName;
  String phone;
  String workerId;

  EmployerWorkerRelation(
      {this.employerID,
      this.isStaff,
      this.pictureUrl,
      this.workerFirstName,
      this.workerLastName,
      this.phone,
      this.workerId});

  factory EmployerWorkerRelation.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      final DocumentReference _employerIdRef = map['employer_ref'];
      final bool _isStaff = map['is_staff'] ?? false;
      final String _pictureURL = map['picture_url'] ?? '';
      final String _firstName = map['worker_first_name'] ?? '';
      final String _lastName = map['worker_last_name'] ?? '';
      final String _phone = map['phone'] ?? '';
      final DocumentReference _workerIdRef = map['worker_ref'];

      return EmployerWorkerRelation(
          employerID: _employerIdRef.id,
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

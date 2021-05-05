import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Workers {
  String docID;
  DateTime createdAt;
  String fullTimeOrganisationId;
  bool isCompleted;
  String firstName;
  String lastName;
  String phone;
  String pictureUrl;
  String uId;
  DateTime updatedAt;

  Workers(
      {this.docID,
      this.createdAt,
      this.fullTimeOrganisationId,
      this.isCompleted,
      this.firstName,
      this.lastName,
      this.pictureUrl,
      this.phone,
      this.updatedAt,
      this.uId});

  factory Workers.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      final Timestamp _createdAtTimeStamp = map['created_at'];
      DateTime _createdAtDateTime;
      if (_createdAtTimeStamp != null) {
        _createdAtDateTime = DateTime.fromMillisecondsSinceEpoch(
          _createdAtTimeStamp.millisecondsSinceEpoch,
        );
      }

      final Timestamp _updatedAtTimeStamp = map['updated_at'];
      DateTime _updatedAtDateTime;
      if (_updatedAtTimeStamp != null) {
        _updatedAtDateTime = DateTime.fromMillisecondsSinceEpoch(
          _updatedAtTimeStamp.millisecondsSinceEpoch,
        );
      }

      final DocumentReference _fullTimeOrganisationIdRef =
          map['full_time_organisation_ref'];
      final bool _isCompleted = map['is_completed'] ?? false;
      final String _phone = map['phone'] ?? '';
      final String _uID = map['uid'] ?? '';
      final String _firstName = map['first_name'] ?? '';
      final String _lastName = map['last_name'] ?? '';
      final String _pictureURL = map['picture_url'] ?? '';
      return Workers(
        docID: docID,
        createdAt: _createdAtDateTime,
        uId: _uID,
        fullTimeOrganisationId: _fullTimeOrganisationIdRef.id,
        phone: _phone,
        isCompleted: _isCompleted,
        updatedAt: _updatedAtDateTime,
        firstName: _firstName,
        lastName: _lastName,
        pictureUrl: _pictureURL,
      );
    }
    return null;
  }

  String getName() {
    return '${firstName ?? ''} ${lastName ?? ''}';
  }
}

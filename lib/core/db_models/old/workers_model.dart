import 'package:flutter/cupertino.dart';

class WorkerModel {
  String docID;
  String firstName;
  String lastName;
  String pictureUrl;
  bool isStaff;
  String phone;
  bool hasLoggedIn;

  WorkerModel(
      {this.docID,
      this.firstName,
      this.lastName,
      this.pictureUrl,
      this.isStaff,
      this.phone,
      this.hasLoggedIn});

  factory WorkerModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map != null && map.isNotEmpty) {
      final String _firstName = map['first_name'] ?? '';
      final String _lastName = map['last_name'] ?? '';
      final String _pictureURL = map['picture_url'] ?? '';
      final bool _isStaff = map['is_staff'] ?? false;
      final String _phone = map['phone'] ?? '';
      final bool _hasLoggedIn = map['has_logged_in'] ?? true;
      var workerModel = WorkerModel(
        docID: docID,
        firstName: _firstName,
        lastName: _lastName,
        pictureUrl: _pictureURL,
        isStaff: _isStaff,
        hasLoggedIn: _hasLoggedIn,
        phone: _phone,
      );
      return workerModel;
    }
    return null;
  }

  String getName() {
    return '${firstName ?? ''} ${lastName ?? ''}';
  }
}

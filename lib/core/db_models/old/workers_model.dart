import 'package:flutter/cupertino.dart';

class WorkerModel {
  String docID;
  String firstName;
  String lastName;
  String pictureUrl;
  bool isStaff;

  WorkerModel({
    this.docID,
    this.firstName,
    this.lastName,
    this.pictureUrl,
    this.isStaff,
  });

  factory WorkerModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map != null && map.isNotEmpty) {
      final String _firstName = map['first_name'] ?? '';
      final String _lastName = map['last_name'] ?? '';
      final String _pictureURL = map['picture_url'] ?? '';
      final bool _isStaff = map['is_staff'] ?? false;
      var workerModel = WorkerModel(
          docID: docID,
          firstName: _firstName,
          lastName: _lastName,
          pictureUrl: _pictureURL,
          isStaff: _isStaff);
      return workerModel;
    }
    return null;
  }

  String getName() {
    return '${firstName ?? ''} ${lastName ?? ''}';
  }
}

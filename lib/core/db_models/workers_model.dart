import 'package:flutter/cupertino.dart';

class WorkerModel {
  String docID;
  String firstName;
  String lastName;
  String pictureUrl;

  WorkerModel({
    this.docID,
    this.firstName,
    this.lastName,
    this.pictureUrl,
  });

  factory WorkerModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      final String _firstName = map['first_name'] ?? '';
      final String _lastName = map['last_name'] ?? '';
      final String _pictureURL = map['picture_url'] ?? '';
      return WorkerModel(
        docID: docID,
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

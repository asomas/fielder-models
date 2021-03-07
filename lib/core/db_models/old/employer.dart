import 'package:flutter/cupertino.dart';

class Employer {
  String docID;
  String name;

  Employer({
    this.docID,
    this.name,
  });

  factory Employer.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      final String _name = map['name'] ?? '';
      if (_name.isNotEmpty) {
        return Employer(
          docID: docID,
          name: _name,
        );
      }
    }
    return null;
  }

  List<String> toJSON() {
    return [];
  }
}

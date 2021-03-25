import 'package:flutter/cupertino.dart';

class Organisation {
  String docID;
  String name;

  Organisation({
    this.docID,
    this.name,
  });

  factory Organisation.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      final String _name = map['name'] ?? '';
      if (_name.isNotEmpty) {
        return Organisation(
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

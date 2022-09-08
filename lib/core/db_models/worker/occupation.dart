import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/helpers.dart';
import 'package:fielder_models/core/db_models/old/schema/table_collection_schema.dart';
import 'package:fielder_models/core/db_models/worker/schema/occupationSchema.dart';

class OccupationModel {
  OccupationModel(
      {this.occupationId,
      this.value,
      this.description,
      this.occupationRef,
      this.category});

  DocumentReference occupationRef;
  String occupationId;
  String value;
  String description;
  String category;

  factory OccupationModel.fromJson(Map<String, dynamic> json) {
    if (json != null && json.isNotEmpty) {
      DocumentReference _occupationRef;
      var _occupationRefTemp = json[OccupationSchema.occupationRef];
      if (_occupationRefTemp is String) {
        _occupationRef =
            Helpers.documentReferenceFromString(_occupationRefTemp);
      } else {
        _occupationRef = _occupationRefTemp;
      }

      if (_occupationRef == null) {
        _occupationRef = FirebaseFirestore.instance
            .collection(FbCollections.occupations)
            .doc(json[OccupationSchema.occupationId]);
      }

      return OccupationModel(
        occupationId: json[OccupationSchema.occupationId] ?? _occupationRef?.id,
        occupationRef: _occupationRef,
        value: json[OccupationSchema.occupationValue],
        description: json[OccupationSchema.description],
        category: json[OccupationSchema.category],
      );
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      OccupationSchema.occupationId: occupationId,
      OccupationSchema.occupationRef:
          occupationRef?.path ?? "${FbCollections.occupations}/$occupationId",
      OccupationSchema.occupationValue: value,
      OccupationSchema.description: description,
      OccupationSchema.category: category,
    };
    json.removeWhere((key, value) => value == null || value.toString().isEmpty);
    return json;
  }
}

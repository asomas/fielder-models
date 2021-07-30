import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/schema/table_collection_schema.dart';
import 'package:fielder_models/core/db_models/worker/schema/occupationSchema.dart';

class OccupationModel {
  OccupationModel(
      {this.occupationId, this.value, this.description, this.occupationRef});

  DocumentReference occupationRef;
  String occupationId;
  String value;
  String description;

  factory OccupationModel.fromJson(Map<String, dynamic> json) {
    if (json != null && json.isNotEmpty) {
      DocumentReference _occupationRef =
          json[OccupationSchema.occupationRef] as DocumentReference;

      return OccupationModel(
        occupationId: json[OccupationSchema.occupationId] ?? _occupationRef?.id,
        occupationRef: _occupationRef,
        value: json[OccupationSchema.value],
        description: json[OccupationSchema.description],
      );
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
        OccupationSchema.occupationId: occupationId,
        OccupationSchema.occupationRef: occupationRef?.toString() ??
            "${FbCollections.occupations}/$occupationId",
        OccupationSchema.value: value,
        OccupationSchema.description: description
      };
}

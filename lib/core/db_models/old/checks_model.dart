import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/schema/check_model_schema.dart';
import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/old/schema/job_template_schema.dart';

class CheckModel {
  String checkID;
  String value;
  String label;
  List<DocumentReference> dependsOn;

  CheckModel({
    this.checkID,
    this.value,
    this.label,
    this.dependsOn,
  });

  factory CheckModel.fromMap({
    @required Map<String, dynamic> map,
    @required String checkID,
  }) {
    if (map.isNotEmpty) {
      String _value;
      if (map.containsKey(CheckModelSchema.value)) {
        _value = map[CheckModelSchema.value] ?? '';
      } else if (map.containsKey(JobTemplateSchema.checkValue)) {
        _value = map[JobTemplateSchema.checkValue] ?? '';
      }
      final _label = map[CheckModelSchema.checkInstructionText];
      final List<DocumentReference> _dependentIds =
          (map[CheckModelSchema.checkDependsOn] as List).map((e) => e as DocumentReference).toList();
      if (_value.isNotEmpty) {
        return CheckModel(
          checkID: checkID,
          value: _value,
          label: _label,
          dependsOn: _dependentIds,
        );
      }
    }
    return null;
  }

  factory CheckModel.fromString(String value) {
    if (value != null && value.isNotEmpty) {
      return CheckModel(
        value: value,
      );
    }
    return null;
  }
}

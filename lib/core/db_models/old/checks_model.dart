import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/schema/check_model_schema.dart';
import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/old/schema/job_template_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/worker_checks_schema.dart';

import '../../enums/enums.dart';
import '../helpers/enum_helpers.dart';

class CheckModel {
  String checkID;
  String value;
  String instructionText;
  List<DocumentReference> dependsOn;
  CheckType checkType;
  String workerAppScreenName;
  bool isSelected = false;
  bool isDisabled = false;

  CheckModel({
    this.checkID,
    this.value,
    this.instructionText,
    this.dependsOn,
    this.checkType,
    this.workerAppScreenName,
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
      final _instructionText = map[CheckModelSchema.checkInstructionText];
      final List<DocumentReference> _dependentIds =
          ((map[CheckModelSchema.checkDependsOn] ?? []) as List).map((e) => e as DocumentReference).toList();
      if (_value.isNotEmpty) {
        return CheckModel(
          checkID: checkID,
          value: _value,
          instructionText: _instructionText,
          dependsOn: _dependentIds,
          checkType: EnumHelpers.getCheckTypeFromString(
            map[WorkerChecksSchema.checkType],
          ),
          workerAppScreenName: map[WorkerChecksSchema.workerAppScreen],
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

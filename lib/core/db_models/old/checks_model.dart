import 'package:fielder_models/core/db_models/old/schema/job_template_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/worker_checks_schema.dart';
import 'package:flutter/cupertino.dart';

import '../../enums/enums.dart';
import '../helpers/enum_helpers.dart';

class CheckModel {
  String checkID;
  String value;
  CheckType checkType;
  String workerAppScreenName;

  CheckModel({
    this.checkID,
    this.value,
    this.checkType,
    this.workerAppScreenName,
  });

  factory CheckModel.fromMap({
    @required Map<String, dynamic> map,
    @required String checkID,
  }) {
    if (map.isNotEmpty) {
      String _value;
      if (map.containsKey("value")) {
        _value = map['value'] ?? '';
      } else if (map.containsKey(JobTemplateSchema.checkValue)) {
        _value = map[JobTemplateSchema.checkValue] ?? '';
      }
      if (_value.isNotEmpty) {
        return CheckModel(
          checkID: checkID,
          value: _value,
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

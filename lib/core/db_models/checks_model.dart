import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/schema/job_template_schema.dart';

class CheckModel{
  String checkID;
  String value;

  CheckModel({
    this.checkID,
    this.value,
  });

  factory CheckModel.fromMap({
    @required Map<String, dynamic> map,
    @required String checkID="",
  }) {
    if (map.isNotEmpty) {
      String _value;
      if(map.containsKey("value")){
        _value = map['value'] ?? '';
      }
      else if(map.containsKey(JobTemplateSchema.checkValue)){
        _value = map[JobTemplateSchema.checkValue] ?? '';
      }
      if (_value.isNotEmpty) {
        return CheckModel(
          checkID: checkID,
          value: _value,
        );
      }
    }
    return null;
  }
}

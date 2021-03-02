import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/schema/job_template_schema.dart';

class SkillsModel {
  String docID;
  String value;

  SkillsModel({
    this.docID,
    this.value,
  });

  factory SkillsModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      String _value;
      if(map.containsKey("value")){
        _value = map['value'] ?? '';
      }
      else if(map.containsKey(JobTemplateSchema.skillValue)){
        _value = map[JobTemplateSchema.skillValue] ?? '';
      }
      if (_value.isNotEmpty) {
        return SkillsModel(
          docID: docID,
          value: _value,
        );
      }
    }
    return null;
  }

  List<String> toJSON() {
    return [];
  }
}
import 'package:fielder_models/core/db_models/old/schema/job_template_schema.dart';
import 'package:flutter/cupertino.dart';

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

  factory SkillsModel.fromString(String value){
    if(value != null && value.isNotEmpty){
      return SkillsModel(
        value: value,
      );
    }
    return null;
  }

  List<String> toJSON() {
    return [];
  }
}

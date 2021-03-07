import 'package:fielder_models/core/db_models/old/schema/job_template_schema.dart';
import 'package:flutter/cupertino.dart';

class QualificationModel {
  String docID;
  String value;

  QualificationModel({
    this.docID,
    this.value,
  });

  factory QualificationModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
       String _value;
      if(map.containsKey("value")){
        _value = map['value'] ?? '';
      }
      else if(map.containsKey(JobTemplateSchema.qualificationValue)){
        _value = map[JobTemplateSchema.qualificationValue] ?? '';
      }
      if (_value.isNotEmpty) {
        return QualificationModel(
          docID: docID,
          value: _value,
        );
      }
    }
    return null;
  }
}

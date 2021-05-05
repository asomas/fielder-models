import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/old/schema/job_template_schema.dart';

class AdditionalInfoModel {
  String docID;
  String value;

  AdditionalInfoModel({
    this.docID,
    this.value,
  });

  factory AdditionalInfoModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if ((map != null) && (map.isNotEmpty)) {
      String _value;
      if (map.containsKey("value")) {
        _value = map['value'] ?? '';
      } else if (map
          .containsKey(JobTemplateSchema.additionalRequirementValue)) {
        _value = map[JobTemplateSchema.additionalRequirementValue] ?? '';
      }
      if (_value.isNotEmpty) {
        return AdditionalInfoModel(
          docID: docID,
          value: _value,
        );
      }
    }
    return null;
  }
}

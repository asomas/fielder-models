import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/schema/skills_table_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/table_collection_schema.dart';
import 'package:flutter/cupertino.dart';

import '../helpers/helpers.dart';

class SkillsModel {
  String docID;
  String value;
  DocumentReference skillRef;
  String category;
  num relevancyScore;

  SkillsModel({
    this.docID,
    this.value,
    this.category,
    this.skillRef,
    this.relevancyScore,
  });

  factory SkillsModel.fromMap({
    @required Map<String, dynamic> map,
    String docID,
  }) {
    if (map.isNotEmpty) {
      try {
        DocumentReference _skillsRef;
        var _skillsRefTemp = map[SkillsSchema.skillRef];
        if (_skillsRefTemp is String) {
          _skillsRef = Helpers.documentReferenceFromString(_skillsRefTemp);
        } else {
          _skillsRef = _skillsRefTemp;
        }

        if (_skillsRef == null && docID != null) {
          _skillsRef = FirebaseFirestore.instance
              .collection(FbCollections.skills)
              .doc(docID);
        }

        return SkillsModel(
            docID: docID ?? _skillsRef?.id,
            skillRef: _skillsRef,
            value: map[SkillsSchema.skillValue],
            relevancyScore: map[SkillsSchema.relevancyScore] ?? 0,
            category: map[SkillsSchema.category]);
      } catch (e, s) {
        print("skills model catch____${e}____$s");
      }
    }
    return null;
  }

  factory SkillsModel.fromString(String value) {
    if (value != null && value.isNotEmpty) {
      return SkillsModel(
        value: value,
      );
    }
    return null;
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> json = {
      SkillsSchema.skillId: docID,
      SkillsSchema.skillRef: skillRef?.path ?? "${FbCollections.skills}/$docID",
      SkillsSchema.skillValue: value,
      SkillsSchema.relevancyScore: relevancyScore,
      SkillsSchema.category: category,
    };
    json.removeWhere((key, value) => value == null || value.toString().isEmpty);
    return json;
  }
}

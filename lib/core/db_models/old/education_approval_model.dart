import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/old/schema/education_approval_schema.dart';

import '../../enums/enums.dart';

class EducationApprovalModel {
  DateTime signedAt;
  EducationApprovalStatus status;

  EducationApprovalModel({this.signedAt, this.status});

  factory EducationApprovalModel.fromMap(Map map) {
    if (map != null && map.isNotEmpty) {
      try {
        return EducationApprovalModel(
          signedAt:
              (map[EducationApprovalSchema.signedAt] as Timestamp)?.toDate(),
          status: EnumHelpers.statusFromEducationApprovalString(
              map[EducationApprovalSchema.status]),
        );
      } catch (e, s) {
        print("education approval model catch___${e}____$s");
        return null;
      }
    }
    return null;
  }
}

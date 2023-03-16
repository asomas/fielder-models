import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/helpers/helpers.dart';
import 'package:fielder_models/core/db_models/old/schema/right_to_work_schema.dart';
import 'package:fielder_models/core/enums/enums.dart';

class RightToWork {
  VerificationStatus verificationStatus;
  bool submitted;
  String shareCode;
  DateTime submittedAt;

  RightToWork(
      {this.verificationStatus,
      this.submitted,
      this.shareCode,
      this.submittedAt});

  factory RightToWork.fromMap(Map map) {
    try {
      return RightToWork(
          verificationStatus: map.containsKey(RightToWorkSchema.status)
              ? EnumHelpers.rightToWorkVerificationStatusFromString(
                  map[RightToWorkSchema.status])
              : VerificationStatus.None,
          submitted: map[RightToWorkSchema.submitted] ?? false,
          shareCode: map[RightToWorkSchema.shareCode],
          submittedAt:
              (map[RightToWorkSchema.submittedAt] as Timestamp)?.toDate());
    } catch (e, s) {
      print('right to work model catch $e, $s');
      return null;
    }
  }

  // Map<String, dynamic> rightToWorkJson() {
  //   return {
  //     RightToWorkSchema.verificationPath:
  //         EnumHelpers.rightToWorkFlowFromEnums(verificationFlow),
  //     RightToWorkSchema.status:
  //         EnumHelpers.rightToWorkVerificationStatusFromEnum(verificationStatus),
  //     RightToWorkSchema.submitted: submitted,
  //     RightToWorkSchema.shareCode: shareCode,
  //     RightToWorkSchema.submittedAt: submittedAt,
  //   };
  // }
}

class RightToWorkDocumentTypeModel {
  final String stepName;
  final DocumentReference workerDocumentRef;
  final String idDocLevel;

  RightToWorkDocumentTypeModel(
      {this.stepName, this.workerDocumentRef, this.idDocLevel});

  factory RightToWorkDocumentTypeModel.fromMap(Map map) {
    try {
      return RightToWorkDocumentTypeModel(
        stepName: map[RightToWorkSchema.stepName],
        workerDocumentRef: Helpers.documentReferenceFromString(
            map[RightToWorkSchema.workerDocumentRef]),
        idDocLevel: map[RightToWorkSchema.idDocLevel],
      );
    } catch (e, s) {
      print('right to work document parsing catch____${e}____$s');
      return null;
    }
  }
}

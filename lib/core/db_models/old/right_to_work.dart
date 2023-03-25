import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/helpers.dart';
import 'package:fielder_models/core/db_models/old/schema/right_to_work_schema.dart';

class RightToWork {
  bool submitted;
  DateTime submittedAt;

  RightToWork({this.submitted, this.submittedAt});

  factory RightToWork.fromMap(Map map) {
    try {
      return RightToWork(
          submitted: map[RightToWorkSchema.submitted] ?? false,
          submittedAt:
              (map[RightToWorkSchema.submittedAt] as Timestamp)?.toDate());
    } catch (e, s) {
      print('right to work model catch $e, $s');
      return null;
    }
  }
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

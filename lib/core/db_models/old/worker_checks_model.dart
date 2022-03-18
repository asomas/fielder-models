import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/old/schema/worker_checks_schema.dart';
import 'package:fielder_models/core/enums/enums.dart';

class WorkerChecksModel {
  String docId;
  DocumentReference checkRef;
  String checkValue;
  DocumentReference workerRef;
  CheckVerificationInfo checkVerificationInfo;
  ChecksType checksType;
  CheckStatus status;

  WorkerChecksModel({
    this.docId,
    this.checkRef,
    this.checkValue,
    this.workerRef,
    this.checkVerificationInfo,
    this.checksType,
    this.status,
  });

  factory WorkerChecksModel.fromMap(String docId, Map map) {
    try {
      return WorkerChecksModel(
        docId: docId,
        checkRef: map[WorkerChecksSchema.checkRef],
        workerRef: map[WorkerChecksSchema.workerRef],
        checkValue: map[WorkerChecksSchema.checkValue],
        checkVerificationInfo: map[WorkerChecksSchema.verificationInfo] != null
            ? CheckVerificationInfo.fromMap(
                map[WorkerChecksSchema.verificationInfo])
            : null,
        checksType: EnumHelpers.getChecksTypeFromString(
            map[WorkerChecksSchema.checkValue]),
        status:
            EnumHelpers.checkStatusFromString(map[WorkerChecksSchema.status]),
      );
    } catch (e, s) {
      print('worker checks model catch___${e}____$s');
      return null;
    }
  }
}

class CheckVerificationInfo {
  DateTime dov;
  bool isValid;
  String source;
  DocumentReference documentRef;

  CheckVerificationInfo(
      {this.dov, this.isValid, this.source, this.documentRef});

  factory CheckVerificationInfo.fromMap(Map map) {
    try {
      return CheckVerificationInfo(
        dov: map[WorkerChecksSchema.dov]?.toDate(),
        isValid: map[WorkerChecksSchema.isValid] ?? false,
        source: map[WorkerChecksSchema.source],
        documentRef: map[WorkerChecksSchema.documentRef],
      );
    } catch (e, s) {
      print('worker checks verification model catch___${e}____$s');
      return null;
    }
  }
}

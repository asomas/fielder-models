import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/old/schema/worker_checks_schema.dart';
import 'package:fielder_models/core/enums/enums.dart';

import '../helpers/date_time_helper.dart';
import '../helpers/helpers.dart';

class WorkerChecksModel {
  String docId;
  DocumentReference checkRef;
  String checkValue;
  DocumentReference workerRef;
  List<CheckVerificationInfo> checkVerificationInfo;
  CheckTypeFromValue checkTypeFromValue;
  CheckType checkType;
  CheckStatus status;
  DateTime expectedCompletionDate;
  DocumentReference organisationRef;

  WorkerChecksModel({
    this.docId,
    this.checkRef,
    this.checkValue,
    this.workerRef,
    this.checkVerificationInfo,
    this.checkTypeFromValue,
    this.status,
    this.expectedCompletionDate,
    this.organisationRef,
    this.checkType,
  });

  factory WorkerChecksModel.fromMap(String docId, Map map) {
    if (map != null && map.isNotEmpty) {
      try {
        return WorkerChecksModel(
          docId: docId,
          checkRef: map[WorkerChecksSchema.checkRef] != null
              ? map[WorkerChecksSchema.checkRef] is String
                  ? Helpers.documentReferenceFromString(
                      map[WorkerChecksSchema.checkRef])
                  : map[WorkerChecksSchema.checkRef]
              : null,
          workerRef: map[WorkerChecksSchema.workerRef] != null
              ? map[WorkerChecksSchema.workerRef] is String
                  ? Helpers.documentReferenceFromString(
                      map[WorkerChecksSchema.workerRef])
                  : map[WorkerChecksSchema.workerRef]
              : null,
          checkValue: map[WorkerChecksSchema.checkValue],
          checkVerificationInfo:
              map[WorkerChecksSchema.verificationInfo] != null
                  ? (map[WorkerChecksSchema.verificationInfo] as List)
                      .map((e) => CheckVerificationInfo.fromMap(e))
                      .toList()
                  : [],
          checkTypeFromValue: EnumHelpers.getCheckTypeFromValueFromString(
              map[WorkerChecksSchema.checkValue]),
          status:
              EnumHelpers.checkStatusFromString(map[WorkerChecksSchema.status]),
          expectedCompletionDate: DateTimeHelper.timeStampFromString(
                  map[WorkerChecksSchema.expectedCompletionAt])
              ?.toDate(),
          organisationRef: map[WorkerChecksSchema.organisationRef],
          checkType: EnumHelpers.getCheckTypeFromString(
              map[WorkerChecksSchema.checkType]),
        );
      } catch (e, s) {
        print('worker checks model catch___${e}____$s');
        return null;
      }
    } else {
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
      var _dov = map[WorkerChecksSchema.dov];
      if (_dov != null && _dov is String) {
        String split = _dov.toString().split("T")[0];
        _dov = Timestamp.fromDate(DateTime.parse(split));
      }
      return CheckVerificationInfo(
        dov: _dov?.toDate(),
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

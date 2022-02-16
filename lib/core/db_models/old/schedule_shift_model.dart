import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/old/schema/schedule_shift_schema.dart';
import 'package:fielder_models/core/db_models/old/workers_model.dart';
import 'package:fielder_models/core/enums/enums.dart';

class ScheduleShiftModel {
  DocumentReference organisationRef;
  DocumentReference organisationUserRef;
  int progressPercentage;
  ScheduleShiftStatus status;
  String step;
  ScheduleShiftResultModel result;

  ScheduleShiftModel({
    this.organisationRef,
    this.organisationUserRef,
    this.progressPercentage,
    this.status,
    this.step,
    this.result,
  });

  factory ScheduleShiftModel.fromMap(Map map) {
    try {
      if (map != null && map.isNotEmpty) {
        return ScheduleShiftModel(
          organisationRef: map[ScheduleShiftSchema.organisationRef],
          organisationUserRef: map[ScheduleShiftSchema.organisationRef],
          progressPercentage: map[ScheduleShiftSchema.progressPercent],
          status: EnumHelpers.getScheduleShiftStatusFromString(
            map[ScheduleShiftSchema.status],
          ),
          step: map[ScheduleShiftSchema.step],
        );
      } else {
        return null;
      }
    } catch (e, s) {
      print("ScheduleShiftModel catch ${e}___$s");
      return null;
    }
  }
}

class ScheduleShiftResultModel {
  ScheduleShiftResultStatus status;
  String statusMessage;
  ScheduleShiftResultDataModel resultDataModel;

  ScheduleShiftResultModel(
      {this.status, this.statusMessage, this.resultDataModel});

  factory ScheduleShiftResultModel.fromMap(Map map) {
    try {
      if (map != null && map.isNotEmpty) {
        return ScheduleShiftResultModel(
          status: EnumHelpers.getScheduleShiftResultStatusFromString(
              map[ScheduleShiftSchema.status]),
          statusMessage: map[ScheduleShiftSchema.statusMessage],
          resultDataModel: ScheduleShiftResultDataModel.fromMap(
            map[ScheduleShiftSchema.data],
          ),
        );
      } else {
        return null;
      }
    } catch (e, s) {
      print("ScheduleShiftResultModel catch ${e}___$s");
      return null;
    }
  }
}

class ScheduleShiftResultDataModel {
  DocumentReference shiftPatternRef;
  DocumentReference workerRef;
  DateTime startDate;
  DateTime endDate;
  WorkerModel workerModel;

  ScheduleShiftResultDataModel({
    this.shiftPatternRef,
    this.workerRef,
    this.startDate,
    this.endDate,
    this.workerModel,
  });

  factory ScheduleShiftResultDataModel.fromMap(Map map) {
    try {
      if (map != null && map.isNotEmpty) {
        return ScheduleShiftResultDataModel(
          shiftPatternRef: map[ScheduleShiftSchema.shiftPatternRef],
          workerRef: map[ScheduleShiftSchema.workerRef],
          startDate:
              (map[ScheduleShiftSchema.startDate] as Timestamp)?.toDate(),
          endDate: (map[ScheduleShiftSchema.endDate] as Timestamp)?.toDate(),
          workerModel: WorkerModel.fromMap(
            map: map[ScheduleShiftSchema.workerData],
            docID:
                (map[ScheduleShiftSchema.workerRef] as DocumentReference)?.id,
          ),
        );
      } else {
        return null;
      }
    } catch (e, s) {
      print("ScheduleShiftResultDataModel catch ${e}___$s");
      return null;
    }
  }
}

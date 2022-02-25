import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/old/schema/schedule_shift_schema.dart';
import 'package:fielder_models/core/db_models/old/workers_model.dart';
import 'package:fielder_models/core/enums/enums.dart';

class ScheduleShiftModel {
  String docId;
  DocumentReference organisationRef;
  DocumentReference organisationUserRef;
  int progressPercentage;
  ScheduleShiftStatus status;
  String step;
  ScheduleShiftResultModel result;
  bool archived;
  DateTime updatedAt;

  ScheduleShiftModel({
    this.docId,
    this.organisationRef,
    this.organisationUserRef,
    this.progressPercentage,
    this.status,
    this.step,
    this.result,
    this.archived,
    this.updatedAt,
  });

  factory ScheduleShiftModel.fromMap(String docId, Map map) {
    try {
      if (map != null && map.isNotEmpty) {
        return ScheduleShiftModel(
            docId: docId,
            organisationRef: map[ScheduleShiftSchema.organisationRef],
            organisationUserRef: map[ScheduleShiftSchema.organisationRef],
            progressPercentage: map[ScheduleShiftSchema.progressPercent],
            archived: map[ScheduleShiftSchema.archived],
            status: EnumHelpers.getScheduleShiftStatusFromString(
              map[ScheduleShiftSchema.status],
            ),
            step: map[ScheduleShiftSchema.step],
            updatedAt:
                (map[ScheduleShiftSchema.updatedAt] as Timestamp).toDate());
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
  List<SchedulerAssignmentModel> assignment;

  ScheduleShiftResultModel({this.status, this.statusMessage, this.assignment});

  factory ScheduleShiftResultModel.fromMap(Map map) {
    try {
      if (map != null && map.isNotEmpty) {
        return ScheduleShiftResultModel(
          status: EnumHelpers.getScheduleShiftResultStatusFromString(
              map[ScheduleShiftSchema.status]),
          statusMessage: map[ScheduleShiftSchema.statusMessage],
          assignment: map[ScheduleShiftSchema.assignments] != null
              ? (map[ScheduleShiftSchema.assignments] as List)
                  ?.map((e) => SchedulerAssignmentModel.fromMap(
                        e,
                      ))
                  ?.toList()
              : null,
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

class SchedulerAssignmentModel {
  DocumentReference shiftPatternRef;
  DocumentReference workerRef;
  DateTime startDate;
  DateTime endDate;
  WorkerModel workerModel;

  SchedulerAssignmentModel({
    this.shiftPatternRef,
    this.workerRef,
    this.startDate,
    this.endDate,
    this.workerModel,
  });

  factory SchedulerAssignmentModel.fromMap(Map map) {
    try {
      if (map != null && map.isNotEmpty) {
        return SchedulerAssignmentModel(
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

  Map<String, dynamic> toJson() {
    return {
      ScheduleShiftSchema.workerId: workerRef?.id,
      ScheduleShiftSchema.shiftPatternId: shiftPatternRef?.id,
      ScheduleShiftSchema.startDate: workerRef?.id,
      ScheduleShiftSchema.endDate: workerRef?.id,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/helpers/helpers.dart';
import 'package:fielder_models/core/db_models/old/schema/schedule_shift_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/table_collection_schema.dart';
import 'package:fielder_models/core/db_models/old/workers_model.dart';
import 'package:fielder_models/core/enums/enums.dart';
import 'package:intl/intl.dart';

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
  String workerId;
  DateTime startDate;
  DateTime endDate;
  WorkerModel workerModel;
  String shiftPatternId;

  SchedulerAssignmentModel({
    this.shiftPatternRef,
    this.workerId,
    this.startDate,
    this.endDate,
    this.workerModel,
    this.shiftPatternId,
  });

  factory SchedulerAssignmentModel.fromMap(Map map) {
    try {
      if (map != null && map.isNotEmpty) {
        String shiftId = ShiftPeriod(
          matchingRequestId: map[ScheduleShiftSchema.shiftPatternId],
        )?.shiftPatternIdFromMatchingId;
        return SchedulerAssignmentModel(
          shiftPatternId: map[ScheduleShiftSchema.shiftPatternId],
          shiftPatternRef: Helpers.documentReferenceFromString(
              "${FbCollections.jobShifts}/$shiftId"),
          workerId:
              (map[ScheduleShiftSchema.workerRef] as DocumentReference)?.id,
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
      ScheduleShiftSchema.workerId: workerId,
      ScheduleShiftSchema.shiftPatternId: shiftPatternId,
      ScheduleShiftSchema.startDate: yearMonthDay(startDate),
      ScheduleShiftSchema.endDate: yearMonthDay(endDate),
    };
  }

  static String yearMonthDay(DateTime dateTime) {
    if (dateTime != null) return DateFormat("yyyy-MM-dd").format(dateTime);
    return null;
  }
}

class ShiftPeriod {
  String shiftPatternId;
  String matchingRequestId;
  DateTime startDate;
  DateTime endDate;
  String workerId;

  ShiftPeriod(
      {this.shiftPatternId,
      this.matchingRequestId,
      this.startDate,
      this.endDate,
      this.workerId});

  Map<String, dynamic> toJson() => {
        'shift_pattern_id': shiftPatternId,
        'matching_request_id': matchingRequestId,
        'start_date': startDate,
        'end_date': endDate,
        'worker_id': workerId,
      };

  String get shiftPatternIdFromMatchingId {
    try {
      List<String> splitIds = matchingRequestId?.split('_');
      return splitIds?.first;
    } catch (e, s) {
      print("schedule matching id get error_____${e}____$s");
      return '';
    }
  }
}

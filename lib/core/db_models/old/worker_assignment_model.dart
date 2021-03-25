import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/shift_pattern_data_model.dart';

import 'package:flutter/cupertino.dart';

import 'package:fielder_models/core/db_models/old/worker_log_model.dart';

class WorkerAssignmentModel {
  final String docID;
  final DateTime endDate;
  ShiftPatternDataModel jobShift;
  WorkerLogModel log;
  final DateTime startDate;
  final String workerID;

  WorkerAssignmentModel({
    this.docID,
    this.workerID,
    this.startDate,
    this.endDate,
    this.jobShift,
    this.log,
  }) : assert(
          docID != null &&
              endDate != null &&
              jobShift != null &&
              startDate != null &&
              workerID != null,
        );

  factory WorkerAssignmentModel.fromMap({
    @required String docID,
    @required String jobShiftID,
    @required Map<String, dynamic> map,
    @required String workerID,
  }) {
    if (map.isNotEmpty) {
      try {
        final Timestamp _startTimeStamp = map['start_date'];
        DateTime _startDate;
        if (_startTimeStamp != null) {
          _startDate = DateTime.fromMillisecondsSinceEpoch(
            _startTimeStamp.millisecondsSinceEpoch,
          );
        }
        final Timestamp _endTimeStamp = map['end_date'];
        DateTime _endDate;
        if (_endTimeStamp != null) {
          _endDate = DateTime.fromMillisecondsSinceEpoch(
            _endTimeStamp.millisecondsSinceEpoch,
          );
        }
        final ShiftPatternDataModel _jobShiftData = ShiftPatternDataModel.fromMap(
          docID: jobShiftID,
          map: map['shift_pattern_pattern_data'] ?? {},
        );

        WorkerLogModel _workerLog;
        final DocumentReference logRefDr = map['worker_log_ref'];

        if (logRefDr != null) {
          _workerLog = WorkerLogModel.fromMap(
            docID: logRefDr.id,
            map: map['worker_log_data'] ?? {},
          );
        }

        return WorkerAssignmentModel(
          docID: docID,
          workerID: workerID,
          startDate: _startDate,
          endDate: _endDate,
          jobShift: _jobShiftData,
          log: _workerLog,
        );
      } catch (e) {
        print('WorkerAssignmentModel.fromMap error: $e');
      }
    }
    return null;
  }
}

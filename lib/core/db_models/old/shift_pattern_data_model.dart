import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/temp/organisation.dart';
import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/old/organisation_model.dart';
import 'package:fielder_models/core/db_models/old/schema/shift_pattern_data_schema.dart';
import 'package:fielder_models/core/db_models/old/pattern_data_model.dart';
import 'package:fielder_models/core/db_models/old/shift_pattern_location_model.dart';
import 'package:fielder_models/core/db_models/old/worker_tracked_time_model.dart';
import 'package:fielder_models/core/db_models/old/workers_model.dart';

class ShiftPatternDataModel {
  String docID;
  OrganisationModel organisation;
  DocumentReference supervisorRef;
  DocumentReference managerRef;
  DateTime endDate;
  int endTimeInt;
  String jobTitle;
  String jobID;
  RecurrenceModel recurrence;
  String role;
  DateTime startDate;
  int startTimeInt;
  String workerId;
  WorkerTrackedTimeModel workerLogModel;
  WorkerModel workerModel;
  ShiftLocationDataModel shiftPatternLocationDataModel;

  ShiftPatternDataModel(
      {this.docID,
      this.organisation,
      this.endDate,
      this.endTimeInt,
      this.jobTitle,
      this.jobID,
      this.recurrence,
      this.role,
      this.startDate,
      this.startTimeInt,
      this.workerId,
      this.workerLogModel,
      this.shiftPatternLocationDataModel,
      this.workerModel,
      this.supervisorRef,
      this.managerRef})
      : assert(
          docID != null &&
              organisation != null &&
              endDate != null &&
              endTimeInt != null &&
              jobID != null &&
              recurrence != null &&
              startDate != null &&
              startTimeInt != null,
        );

  factory ShiftPatternDataModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
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
        final int _startTimeInt = map['start_time'];
        final int _endTimeInt = map['end_time'];
        final RecurrenceModel _recurrence = RecurrenceModel.fromMap(
          map: map['recurrence'] ?? {},
        );
        final String _jobTitle = map['job_title'] ?? '';
        final DocumentReference _jobRef = map['job_ref'] ?? '';
        final String _role = map['role'] ?? '';
        OrganisationModel _organisation;
        ShiftLocationDataModel _shift_patternLocationDataModel;
        final DocumentReference _organisationRef = map['organisation_ref'];
        final DocumentReference _locationRef = map['location_ref'];
        final DocumentReference _supervisorRef = map['supervisor_ref'];
        final DocumentReference _managerRef = map['manager_ref'];

        if (_organisationRef != null) {
          _organisation = OrganisationModel.fromMap(
            docID: _organisationRef.id,
            map: map['organisation_data'] ?? {},
          );
        }
        if (_locationRef != null) {
          _shift_patternLocationDataModel = ShiftLocationDataModel.fromMap(
              map["location_data"]
          );
        }
        WorkerTrackedTimeModel _workerLogModel;
        final DocumentReference _workerRef = map['worker_ref'];
        final DocumentReference _workerLogRef =
            map['shift_activity_ref'] ;

        if (_workerRef != null && _workerLogRef != null) {
          _workerLogModel = WorkerTrackedTimeModel.fromMap(
              map: map['worker_tracked_time_data'] ?? {}, docID: _workerLogRef.id);
        }
        if (_jobRef != null) {
          return ShiftPatternDataModel(
            docID: docID,
            startDate: _startDate,
            endDate: _endDate,
            startTimeInt: _startTimeInt,
            endTimeInt: _endTimeInt,
            recurrence: _recurrence,
            jobTitle: _jobTitle,
            jobID: _jobRef?.id,
            role: _role,
            organisation: _organisation,
            supervisorRef: _supervisorRef,
            managerRef: _managerRef,
              shiftPatternLocationDataModel: _shift_patternLocationDataModel,
            workerLogModel: _workerLogModel,
            workerId: _workerRef?.id,
            workerModel: map.containsKey(ShiftDataSchema.workerData)
                  ? WorkerModel.fromMap(map: map[ShiftDataSchema.workerData],
                  docID: map[ShiftDataSchema.workerRef]?.id) : null
          );
        }
      } catch (e) {
        print('ShiftPatternDataModel fromMap error: $e');
      }
    }
    return null;
  }
}

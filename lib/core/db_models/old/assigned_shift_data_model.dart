import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/old/organisation_model.dart';
import 'package:fielder_models/core/db_models/old/shift_data_model.dart';
import 'package:fielder_models/core/db_models/old/workers_model.dart';

class AssignedShiftDataModel {
  String docID;
  OrganisationModel organisation;
  DateTime endDate;
  int endTimeInt;
  String jobTitle;
  String jobID;
  RecurrenceModel recurrence;
  String role;
  DateTime startDate;
  int startTimeInt;
  String workerId;
  WorkerModel worker;

  AssignedShiftDataModel({
    this.docID,
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
    this.worker,
  }) : assert(
          docID != null &&
              organisation != null &&
              endDate != null &&
              endTimeInt != null &&
              jobID != null &&
              recurrence != null &&
              startDate != null &&
              startTimeInt != null,
        );

  factory AssignedShiftDataModel.fromMap({
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
        WorkerModel _worker;
        final DocumentReference _organisationRef = map['organisation_ref'];
        final DocumentReference _workerRef = map['worker_ref'];

        if (_organisationRef != null) {
          _organisation = OrganisationModel.fromMap(
            docID: _organisationRef.id,
            map: map['organisation_data'] ?? {},
          );
        }

        if (_workerRef != null) {
          _worker = WorkerModel.fromMap(
              map: map["worker_data"] ?? {},
              docID: _workerRef.id
          );
        }
        if (_jobRef != null) {
          return AssignedShiftDataModel(
            docID: docID,
            startDate: _startDate,
            endDate: _endDate,
            startTimeInt: _startTimeInt,
            endTimeInt: _endTimeInt,
            recurrence: _recurrence,
            jobTitle: _jobTitle,
            jobID: _jobRef.id,
            role: _role,
            organisation: _organisation,
            worker: _worker,
            workerId:_workerRef.id,
          );
        }
      } catch (e) {
        print('Assigned Shift fromMap error: $e');
      }
    }
    return null;
  }
}

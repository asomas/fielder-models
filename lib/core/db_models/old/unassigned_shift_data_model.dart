import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/old/employer_model.dart';
import 'package:fielder_models/core/db_models/old/shift_data_model.dart';

class UnassignedShiftDataModel {
  String docID;
  EmployerModel employer;
  DateTime endDate;
  int endTimeInt;
  String jobTitle;
  String jobID;
  RecurrenceModel recurrence;
  String role;
  DateTime startDate;
  int startTimeInt;

  UnassignedShiftDataModel({
    this.docID,
    this.employer,
    this.endDate,
    this.endTimeInt,
    this.jobTitle,
    this.jobID,
    this.recurrence,
    this.role,
    this.startDate,
    this.startTimeInt,
  }) : assert(
          docID != null &&
              employer != null &&
              endDate != null &&
              endTimeInt != null &&
              jobID != null &&
              recurrence != null &&
              startDate != null &&
              startTimeInt != null,
        );

  factory UnassignedShiftDataModel.fromMap({
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
        EmployerModel _employer;
        final DocumentReference _employerRef = map['employer_ref'];

        if (_employerRef != null) {
          _employer = EmployerModel.fromMap(
            docID: _employerRef.id,
            map: map['employer_data'] ?? {},
          );
        }

        if (_jobRef != null) {
          return UnassignedShiftDataModel(
            docID: docID,
            startDate: _startDate,
            endDate: _endDate,
            startTimeInt: _startTimeInt,
            endTimeInt: _endTimeInt,
            recurrence: _recurrence,
            jobTitle: _jobTitle,
            jobID: _jobRef.id,
            role: _role,
            employer: _employer,
          );
        }
      } catch (e) {
        print('Unassigned JobShiftDataModel fromMap error: $e');
      }
    }
    return null;
  }
}

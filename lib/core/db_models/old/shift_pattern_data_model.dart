import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/temp/organisation.dart';
import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/old/organisation_model.dart';
import 'package:fielder_models/core/db_models/old/schema/shift_pattern_data_schema.dart';
import 'package:fielder_models/core/db_models/old/pattern_data_model.dart';
import 'package:fielder_models/core/db_models/old/shift_pattern_location_model.dart';
import 'package:fielder_models/core/db_models/old/shift_activities_model.dart';
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
  ShiftActivitiesModel shiftActivitiesModel;
  WorkerModel workerModel;
  ShiftLocationDataModel shiftLocationDataModel;
  bool isUnavailableForOrganisation;

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
      this.shiftActivitiesModel,
      this.shiftLocationDataModel,
      this.workerModel,
      this.supervisorRef,
      this.managerRef,
      this.isUnavailableForOrganisation = false
      });

  factory ShiftPatternDataModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
    bool isUnavailable = false
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
        ShiftLocationDataModel _shiftLocationDataModel;
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
          _shiftLocationDataModel = ShiftLocationDataModel.fromMap(
              map["location_data"]
          );
        }
        ShiftActivitiesModel _shiftActivitiesModel;
        final DocumentReference _workerRef = map['worker_ref'];
        final DocumentReference _shiftActivityRef =
            map['shift_activity_ref'] ;

        if (_workerRef != null && _shiftActivityRef != null) {
          _shiftActivitiesModel = ShiftActivitiesModel.fromMap(
              map: map['shift_activity_data'] ?? {}, docID: _shiftActivityRef.id);
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
            isUnavailableForOrganisation: isUnavailable,
            organisation: _organisation,
            supervisorRef: _supervisorRef,
            managerRef: _managerRef,
              shiftLocationDataModel: _shiftLocationDataModel,
            shiftActivitiesModel: null,//_shiftActivitiesModel,
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

  ShiftPatternDataModel copyWith(ShiftPatternDataModel shiftPatternDataModel){
    return ShiftPatternDataModel(
        docID: shiftPatternDataModel.docID,
        startDate: shiftPatternDataModel.startDate,
        endDate: shiftPatternDataModel.endDate,
        startTimeInt: shiftPatternDataModel.startTimeInt,
        endTimeInt: shiftPatternDataModel.endTimeInt,
        recurrence: shiftPatternDataModel.recurrence,
        jobTitle: shiftPatternDataModel.jobTitle,
        jobID: shiftPatternDataModel.jobID,
        role: shiftPatternDataModel.role,
        organisation: shiftPatternDataModel.organisation,
        supervisorRef: shiftPatternDataModel.supervisorRef,
        managerRef: shiftPatternDataModel.managerRef,
        shiftLocationDataModel: shiftPatternDataModel.shiftLocationDataModel,
        shiftActivitiesModel: shiftPatternDataModel.shiftActivitiesModel,
        workerId: shiftPatternDataModel.workerId,
        workerModel: shiftPatternDataModel.workerModel
    );
  }
}

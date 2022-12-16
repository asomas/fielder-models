import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/address_model.dart';
import 'package:fielder_models/core/db_models/old/budget_model.dart';
import 'package:fielder_models/core/db_models/old/job_data_model.dart';
import 'package:fielder_models/core/db_models/old/organisation_model.dart';
import 'package:fielder_models/core/db_models/old/pattern_data_model.dart';
import 'package:fielder_models/core/db_models/old/schema/candidates_matching_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/groups_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/job_summary_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/schedule_shift_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/shift_pattern_data_schema.dart';
import 'package:fielder_models/core/db_models/old/shift_activities_model.dart';
import 'package:fielder_models/core/db_models/old/workers_model.dart';
import 'package:fielder_models/core/db_models/worker/locationModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../worker/schema/locationSchema.dart';

class ShiftPatternDataModel {
  String docID;
  String shiftPatternRefId;
  OrganisationModel organisation;
  DocumentReference supervisorRef;
  DocumentReference managerRef;
  DateTime endDate;
  int endTimeInt;
  String jobTitle;
  String jobRefId;
  String jobID;
  RecurrenceModel recurrence;
  String role;
  DateTime startDate;
  int startTimeInt;
  String workerId;
  ShiftActivitiesModel shiftActivitiesModel;
  WorkerModel workerModel;
  LocationModelDetail shiftLocationDataModel;
  DocumentReference locationRef;
  bool isUnavailableForOrganisation;
  bool isRecurring;
  bool assigned;
  String startTimeString;
  String endTimeString;
  bool isGeoFencingEnabled;
  double geoFenceRadius;
  DocumentReference shiftNoteRef;
  bool multiDayShift;
  bool isHeadOFTheShift;
  bool isTailOFTheShift;
  bool enableUnpaidBreaks;
  BudgetModel budget;
  DocumentReference groupRef;

  ShiftPatternDataModel({
    this.docID,
    this.shiftPatternRefId,
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
    this.locationRef,
    this.workerModel,
    this.supervisorRef,
    this.jobRefId,
    this.managerRef,
    this.isUnavailableForOrganisation = false,
    this.isRecurring,
    this.assigned = false,
    this.startTimeString,
    this.endTimeString,
    this.isGeoFencingEnabled = false,
    this.geoFenceRadius = 0,
    this.shiftNoteRef,
    this.multiDayShift,
    this.isHeadOFTheShift,
    this.isTailOFTheShift,
    this.enableUnpaidBreaks,
    this.budget,
    this.groupRef,
  });

  static const String dateFormatWithHyphen = "yyyy-MM-dd";
  static String yearMonthDay(DateTime dateTime) {
    if (dateTime != null)
      return DateFormat(dateFormatWithHyphen).format(dateTime);
    return null;
  }

  static String timeStringFromDuration(int secondsFromMidnight) {
    Duration duration = Duration(seconds: secondsFromMidnight?.round());
    String twoDigits(int n) => n.abs().toString().padLeft(2, "0");
    int hours = duration.inHours;
    int mins = duration.inMinutes.remainder(60);
    if (hours > 24) {
      hours = hours - 12;
      TimeOfDay timeOfDay = TimeOfDay(hour: hours, minute: mins);
      timeOfDay = timeOfDay.replacing(hour: timeOfDay.hourOfPeriod);
      hours = timeOfDay.hour;
    }
    if (hours == 24) hours = 0;
    String twoDigitMinutes = twoDigits(mins);
    // String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(hours)}:$twoDigitMinutes";
    // return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  factory ShiftPatternDataModel.fromMap(
      {@required Map<String, dynamic> map,
      @required String docID,
      bool isUnavailable = false}) {
    if (map.isNotEmpty) {
      try {
        final _startTimeStamp = map['start_date'];
        DateTime _startDate;
        if (_startTimeStamp != null) {
          if (_startTimeStamp is Timestamp) {
            _startDate = DateTime.fromMillisecondsSinceEpoch(
              _startTimeStamp.millisecondsSinceEpoch,
            );
          } else {
            _startDate =
                DateTime.parse(_startTimeStamp.toString().split("T")[0]);
          }
        }
        final _endTimeStamp = map['end_date'];
        DateTime _endDate;
        if (_endTimeStamp != null) {
          if (_endTimeStamp is Timestamp) {
            _endDate = DateTime.fromMillisecondsSinceEpoch(
              _endTimeStamp.millisecondsSinceEpoch,
            );
          } else {
            _endDate = DateTime.parse(_endTimeStamp.toString().split("T")[0]);
          }
        }
        final int _startTimeInt = map['start_time'];
        final int _endTimeInt = map['end_time'];

        final String _startTimeStr = timeStringFromDuration(map['start_time']);
        final String _endTimeStr = timeStringFromDuration(map['end_time']);

        final bool _isRecurring = map[ShiftDataSchema.isRecurring] != null
            ? map[ShiftDataSchema.isRecurring]
            : false;
        final bool _assigned = map[ShiftDataSchema.assigned] != null
            ? map[ShiftDataSchema.assigned]
            : false;
        final RecurrenceModel _recurrence = RecurrenceModel.fromMap(
          map: map['recurrence'] ?? {},
        );
        final String _jobTitle = map['job_title'] ?? '';
        final String _jobRefId = map['job_reference_id'];
        final DocumentReference _jobRef = map['job_ref'];
        final DocumentReference _occupationRef = map['organisation_ref'];
        final String _shiftPatternRef = map['shift_pattern_reference_id'];
        final String _role = map['role'] ?? '';
        OrganisationModel _organisation;
        LocationModelDetail _shiftLocationDataModel;
        final DocumentReference _organisationRef = map['organisation_ref'];
        final DocumentReference _locationRef = map['location_ref'];
        final DocumentReference _supervisorRef = map['supervisor_ref'];
        final DocumentReference _managerRef = map['manager_ref'];
        final bool _geoFenceEnabled = map[ShiftDataSchema.geoFenceEnabled];
        double _geoFenceDistance = 0;

        if (map[ShiftDataSchema.geoFenceDistance] != null) {
          try {
            _geoFenceDistance = double.tryParse(
                map[ShiftDataSchema.geoFenceDistance].toString());
          } catch (e) {
            _geoFenceDistance = 0;
            print("geo fencing parse_______$e");
          }
        }

        if (_organisationRef != null) {
          _organisation = OrganisationModel.fromMap(
            docID: _organisationRef.id,
            map: map['organisation_data'] ?? {},
          );
        }
        if (map.containsKey("location_data")) {
          _shiftLocationDataModel =
              LocationModelDetail.fromJson(map["location_data"]);
        }

        final DocumentReference _workerRef = map['worker_ref'];
        final DocumentReference _shiftNoteRef =
            map[ShiftDataSchema.shiftNoteRef];

        return ShiftPatternDataModel(
            docID: docID,
            shiftPatternRefId: _shiftPatternRef,
            startDate: _startDate,
            endDate: _endDate,
            startTimeInt: _startTimeInt,
            endTimeInt: _endTimeInt,
            startTimeString: _startTimeStr,
            endTimeString: _endTimeStr,
            recurrence: _recurrence,
            jobTitle: _jobTitle,
            jobID: _jobRef?.id,
            jobRefId: _jobRefId,
            role: _role,
            isUnavailableForOrganisation: isUnavailable,
            organisation: _organisation,
            supervisorRef: _supervisorRef,
            managerRef: _managerRef,
            shiftLocationDataModel: _shiftLocationDataModel,
            locationRef: _locationRef,
            shiftActivitiesModel: null,
            isRecurring: _isRecurring,
            assigned: _assigned,
            isGeoFencingEnabled: _geoFenceEnabled,
            geoFenceRadius: _geoFenceDistance,
            //_shiftActivitiesModel,
            workerId: _workerRef?.id,
            workerModel: map.containsKey(ShiftDataSchema.workerData)
                ? WorkerModel.fromMap(
                    map: map[ShiftDataSchema.workerData],
                    docID: map[ShiftDataSchema.workerRef]?.id)
                : null,
            shiftNoteRef: _shiftNoteRef,
            multiDayShift: map[ShiftDataSchema.multiDayShift] ?? false,
            enableUnpaidBreaks:
                map[JobSummarySchema.enableUnpaidBreaks] ?? false,
            groupRef: map[GroupsSchema.groupRef]);
      } catch (e) {
        print('ShiftPatternDataModel fromMap error: $e');
      }
    }
    return null;
  }

  ShiftPatternDataModel copyWith(ShiftPatternDataModel shiftPatternDataModel) {
    return ShiftPatternDataModel(
      docID: shiftPatternDataModel.docID,
      startDate: shiftPatternDataModel.startDate,
      endDate: shiftPatternDataModel.endDate,
      startTimeInt: shiftPatternDataModel.startTimeInt,
      endTimeInt: shiftPatternDataModel.endTimeInt,
      recurrence: shiftPatternDataModel.recurrence,
      jobTitle: shiftPatternDataModel.jobTitle,
      jobID: shiftPatternDataModel.jobID,
      jobRefId: shiftPatternDataModel.jobRefId,
      assigned: shiftPatternDataModel.assigned,
      role: shiftPatternDataModel.role,
      organisation: shiftPatternDataModel.organisation,
      supervisorRef: shiftPatternDataModel.supervisorRef,
      managerRef: shiftPatternDataModel.managerRef,
      shiftLocationDataModel: shiftPatternDataModel.shiftLocationDataModel,
      locationRef: shiftPatternDataModel.locationRef,
      shiftActivitiesModel: shiftPatternDataModel.shiftActivitiesModel,
      workerId: shiftPatternDataModel.workerId,
      workerModel: shiftPatternDataModel.workerModel,
      isUnavailableForOrganisation:
          shiftPatternDataModel.isUnavailableForOrganisation,
      shiftPatternRefId: shiftPatternDataModel.shiftPatternRefId,
      geoFenceRadius: shiftPatternDataModel.geoFenceRadius,
      isGeoFencingEnabled: shiftPatternDataModel.isGeoFencingEnabled,
      shiftNoteRef: shiftPatternDataModel.shiftNoteRef,
      multiDayShift: shiftPatternDataModel.multiDayShift,
      startTimeString: shiftPatternDataModel.startTimeString,
      endTimeString: shiftPatternDataModel.endTimeString,
      isRecurring: shiftPatternDataModel.isRecurring,
      enableUnpaidBreaks: shiftPatternDataModel.enableUnpaidBreaks,
      groupRef: shiftPatternDataModel?.groupRef,
    );
  }

  Map<String, dynamic> toMatchingData(JobDataModel jobDataModel) {
    try {
      return {
        ScheduleShiftSchema.shiftId: docID,
        CandidatesMatchingRequestSchema.organisationId: organisation?.docID,
        CandidatesMatchingRequestSchema.startDate: yearMonthDay(startDate),
        CandidatesMatchingRequestSchema.endDate: yearMonthDay(endDate),
        CandidatesMatchingRequestSchema.recurrence: recurrence.toJSON(),
        CandidatesMatchingRequestSchema.skills:
            jobDataModel?.skills?.map((e) => e?.toJSON())?.toList() ?? [],
        CandidatesMatchingRequestSchema.courses: jobDataModel?.courses
                ?.map((e) => e?.toJsonForMatching())
                ?.toList() ??
            [],
        CandidatesMatchingRequestSchema.checks:
            jobDataModel?.checks?.map((e) => e?.checkID)?.toList() ?? [],
        CandidatesMatchingRequestSchema.startTime: startTimeInt,
        CandidatesMatchingRequestSchema.endTime: endTimeInt,
        LocationSchema.address:
            (AddressModel.fromObject(shiftLocationDataModel)).toJsonLocation(),
        ShiftDataSchema.multiDayShift: multiDayShift ?? false,
      };
    } catch (e, s) {
      print("to matching from shift patterns catch___${e}_____$s");
      return {};
    }
  }
}

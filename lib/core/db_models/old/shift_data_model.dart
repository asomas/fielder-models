import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/google_place_model.dart';
import 'package:fielder_models/core/enums/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:fielder_models/core/db_models/schema/shift_data_schema.dart';
import 'package:fielder_models/core/db_models/old/workers_model.dart';

import '../helpers/enum_helpers.dart';
import '../schema/shift_data_schema.dart';

class ShiftDataModel {
  String docID;
  DateTime startDate;
  DateTime endDate;
  int startTimeInt;
  int endTimeInt;
  int intervalAmount;
  String intervalType;
  RecurrenceModel recurrence;
  String existingLocationId;
  GooglePlaceModel googlePlaceModel;
  String title;
  String shiftDate;
  DocumentReference workerRef;
  WorkerModel workerModel;

  ShiftDataModel({
    this.docID,
    this.startDate,
    this.endDate,
    this.startTimeInt,
    this.endTimeInt,
    this.intervalAmount = 1,
    this.intervalType,
    this.recurrence,
    this.title,
    this.existingLocationId,
    this.workerRef,
    this.shiftDate,
    this.googlePlaceModel,
    this.workerModel
  }) : assert(
          startDate != null && startTimeInt != null && endTimeInt != null,
        );

  factory ShiftDataModel.fromMap(String docID, Map<String, dynamic> map){
    ShiftDataModel shiftDataModel;
    try{
      if(map?.isNotEmpty == true){
        shiftDataModel = ShiftDataModel(
            docID: docID,
            title: map[ShiftDataSchema.title] ?? "",
            startDate: map[ShiftDataSchema.startDate]?.toDate(),
            endDate: map[ShiftDataSchema.endDate]?.toDate(),
            startTimeInt: map[ShiftDataSchema.startTime],
            endTimeInt: map[ShiftDataSchema.endTime],
            intervalAmount: map[ShiftDataSchema.intervalAmount],
            intervalType: map[ShiftDataSchema.repeatIntervalType],
            recurrence: RecurrenceModel.fromMap(map: map[ShiftDataSchema.recurrence]),
            workerRef: map[ShiftDataSchema.workerRef],
            shiftDate: map[ShiftDataSchema.shiftDate],
            googlePlaceModel: GooglePlaceModel.fromMap(map[ShiftDataSchema.googlePlaceData],),
            workerModel: map.containsKey(ShiftDataSchema.workerData)
                ? WorkerModel.fromMap(map: map[ShiftDataSchema.workerData],
                docID: map[ShiftDataSchema.workerRef]?.id) : null
        );
      }
      return shiftDataModel;
    }catch(e){
    print('ShiftDataModel toJSON error: $e');
    return null;
    }
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> jsonMap = {};
    try {
      jsonMap = {
        ShiftDataSchema.startDate: DateFormat('yyyy-MM-dd').format(startDate),
        ShiftDataSchema.startTime: startTimeInt,
        ShiftDataSchema.endTime: endTimeInt,
      //  ShiftDataSchema.intervalAmount: intervalAmount,
       // ShiftDataSchema.repeatIntervalType: intervalType,
        ShiftDataSchema.recurrence: recurrence.toJSON(),
      };
      if(existingLocationId!=null){
        jsonMap[ShiftDataSchema.existingLocationId] = existingLocationId;
      }
      else if(googlePlaceModel != null){
        jsonMap[ShiftDataSchema.googlePlaceData] = googlePlaceModel.toJson();
      }
      if (endDate != null) {
        final String _endDateString = DateFormat('yyyy-MM-dd').format(endDate);
        if (_endDateString != null) {
          if(intervalType!="None")
          jsonMap[ShiftDataSchema.endDate] = _endDateString;
        }
      }
      return jsonMap;
    } catch (e) {
      print('ShiftDataModel toJSON error: $e');
      return {};
    }
  }

}

class RecurrenceModel {
  int intervalAmount;
  ShiftFrequencies repeatIntervalType;
  bool isMonday;
  bool isTuesday;
  bool isWednesday;
  bool isThursday;
  bool isFriday;
  bool isSaturday;
  bool isSunday;

  RecurrenceModel({
    this.intervalAmount = 1,
    this.repeatIntervalType = ShiftFrequencies.None,
    this.isMonday = false,
    this.isTuesday = false,
    this.isWednesday = false,
    this.isThursday = false,
    this.isFriday = false,
    this.isSaturday = false,
    this.isSunday = false,
  });

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> recurrenceMap = {};
    try {
      int _intervalAmount = intervalAmount ?? 1;
      String _repeatIntervalType = EnumHelpers.getStringForFrequency(
        shiftFrequency: repeatIntervalType,
      );

      //Backend doesnot support NONE for now
      if (repeatIntervalType == ShiftFrequencies.None) {
        _intervalAmount = 1;
        _repeatIntervalType = 'None';
      }
      recurrenceMap = {
        ShiftDataSchema.intervalAmount: _intervalAmount,
        ShiftDataSchema.repeatIntervalType: _repeatIntervalType,
        ShiftDataSchema.monday: isMonday ?? false,
        ShiftDataSchema.tuesday: isTuesday ?? false,
        ShiftDataSchema.wednesday: isWednesday ?? false,
        ShiftDataSchema.thursday: isThursday ?? false,
        ShiftDataSchema.friday: isFriday ?? false,
        ShiftDataSchema.saturday: isSaturday ?? false,
        ShiftDataSchema.sunday: isSunday ?? false,
      };
      return recurrenceMap;
    } catch (e) {
      print('RecurrenceModel toJSON error: $e');
      return {};
    }
  }

  factory RecurrenceModel.fromMap({
    @required Map<String, dynamic> map,

  }) {
    if (map.isNotEmpty) {
      final int _intervalAmount = map['interval_amount'];
      final ShiftFrequencies _repeatIntervalType= EnumHelpers.getFrequencyForString(shiftFrequency:map['repeat_interval_type'] ?? '');
      final bool _isMonday = map['monday'] ?? false;
      final bool _isTuesday = map['tuesday'] ?? false;
      final bool _isWednesday = map['wednesday'] ?? false;
      final bool _isThursday = map['thursday'] ?? false;
      final bool _isFriday = map['friday'] ?? false;
      final bool _isSaturday = map['saturday'] ?? false;
      final bool _isSunday = map['sunday'] ?? false;


      return RecurrenceModel(
        intervalAmount: _intervalAmount,
        repeatIntervalType: _repeatIntervalType,
        isMonday: _isMonday,
        isTuesday: _isTuesday,
        isWednesday: _isWednesday,
        isThursday: _isThursday,
        isFriday: _isFriday,
        isSaturday: _isSaturday,
        isSunday: _isSunday,
      );
    }
    return null;
  }
}

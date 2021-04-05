import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/schema/shift_actvities_schema.dart';
import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

class ShiftActivitiesModel {
  String docID;
  DateTime clockInTime;
  GeoPoint clockInLocation;
  DateTime clockOutTime;
  DateTime shiftDate;
  GeoPoint clockOutLocation;
  DocumentReference shiftPatternRef;

  ShiftActivitiesModel({
    this.clockInTime,
    this.clockInLocation,
    this.clockOutTime,
    this.clockOutLocation,
    this.shiftDate,
    this.docID,
    this.shiftPatternRef
  }) : assert(
          clockInTime != null && clockInLocation != null && docID != null,
        );

  factory ShiftActivitiesModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      try {
        final DocumentReference _shiftPatternRef = map[ShiftActivitiesSchema.shiftPatternRef];
        final GeoPoint _clockInLocation = map[ShiftActivitiesSchema.clockInLocation];
        final GeoPoint _clockOutLocation = map[ShiftActivitiesSchema.clockOutLocation];
        final Timestamp _clockInTimeStamp = map[ShiftActivitiesSchema.clockInTime];
        final Timestamp _clockOutTimeStamp = map[ShiftActivitiesSchema.clockOutTime];
        final Timestamp _shiftPatternDateTimeStamp = map[ShiftActivitiesSchema.shiftDate];
        DateTime _clockInDateTime;
        if (_clockInTimeStamp != null) {
          _clockInDateTime = DateTime.fromMillisecondsSinceEpoch(
            _clockInTimeStamp.millisecondsSinceEpoch,
          );
        }
        DateTime _clockOutDateTime;
        if (_clockOutTimeStamp != null) {
          _clockOutDateTime = DateTime.fromMillisecondsSinceEpoch(
            _clockOutTimeStamp.millisecondsSinceEpoch,
          );
        }

        DateTime _shiftPatternDateTime;
        if (_shiftPatternDateTimeStamp != null) {
          _shiftPatternDateTime = DateTime.fromMillisecondsSinceEpoch(
            _shiftPatternDateTimeStamp.millisecondsSinceEpoch,
          );
        }

        return ShiftActivitiesModel(
          docID: docID,
          clockInTime: _clockInDateTime,
          clockInLocation: _clockInLocation,
          clockOutTime: _clockOutDateTime,
          shiftDate: _shiftPatternDateTime,
          clockOutLocation: _clockOutLocation,
          shiftPatternRef: _shiftPatternRef
        );
      } on Exception catch (e) {
        print("ShiftActivitiesModel.fromMap error $e");
      }
    }
    return null;
  }
}

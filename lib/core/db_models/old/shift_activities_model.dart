import 'package:cloud_firestore/cloud_firestore.dart';
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
        final DocumentReference _shiftPatternRef = map['shift_pattern_ref'];
        final GeoPoint _clockInLocation = map['clock_in_location'];
        final GeoPoint _clockOutLocation = map['clock_out_location'];
        final Timestamp _clockInTimeStamp = map['clock_in_time'];
        final Timestamp _shiftPatternDateTimeStamp = map['shift_date'];
        DateTime _clockInDateTime;
        if (_clockInTimeStamp != null) {
          _clockInDateTime = DateTime.fromMillisecondsSinceEpoch(
            _clockInTimeStamp.millisecondsSinceEpoch,
          );
        }
        final Timestamp _clockOutTimeStamp = map['clock_out_time'];
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class WorkerTrackedTimeModel {
  String docID;
  DateTime clockInTime;
  GeoPoint clockInLocation;
  DateTime clockOutTime;
  DateTime shiftDate;
  GeoPoint clockOutLocation;

  WorkerTrackedTimeModel({
    this.clockInTime,
    this.clockInLocation,
    this.clockOutTime,
    this.clockOutLocation,
    this.shiftDate,
    this.docID,
  }) : assert(
          clockInTime != null && clockInLocation != null && docID != null,
        );

  factory WorkerTrackedTimeModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      try {
        final GeoPoint _clockInLocation = map['clock_in_location'];
        final GeoPoint _clockOutLocation = map['clock_out_location'];
        final Timestamp _clockInTimeStamp = map['clock_in_time'];
        final Timestamp _shiftDateTimeStamp = map['shift_date'];
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

        DateTime _shiftDateDateTime;
        if (_shiftDateTimeStamp != null) {
          _shiftDateDateTime = DateTime.fromMillisecondsSinceEpoch(
            _shiftDateTimeStamp.millisecondsSinceEpoch,
          );
        }

        return WorkerTrackedTimeModel(
          docID: docID,
          clockInTime: _clockInDateTime,
          clockInLocation: _clockInLocation,
          clockOutTime: _clockOutDateTime,
          shiftDate: _shiftDateDateTime,
          clockOutLocation: _clockOutLocation,
        );
      } on Exception catch (e) {
        print("WorkerTrackedTimeModel.fromMap error $e");
      }
    }
    return null;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class WorkerLogModel {
  String docID;
  DateTime clockInTime;
  GeoPoint clockInLocation;
  DateTime clockOutTime;
  GeoPoint clockOutLocation;
  String workerID;
  DocumentReference jobShiftRef;

  WorkerLogModel({
    this.clockInTime,
    this.clockInLocation,
    this.clockOutTime,
    this.clockOutLocation,
    this.docID,
    this.workerID,
    this.jobShiftRef
  });
      // : assert(
      //     clockInTime != null &&
      //         clockInLocation != null &&
      //         docID != null &&
      //         workerID != null,
      //   );

  factory WorkerLogModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map?.isNotEmpty == true) {
      try {
        final GeoPoint _clockInLocation = map['clock_in_location'];
        final GeoPoint _clockOutLocation = map['clock_out_location'];
        //final DocumentReference _workerRef = map['worker_ref'];
        final Timestamp _clockInTimeStamp = map['clock_in_time'];
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
        return WorkerLogModel(
          docID: docID,
          clockInTime: _clockInDateTime,
          clockInLocation: _clockInLocation,
          clockOutTime: _clockOutDateTime,
          clockOutLocation: _clockOutLocation,
          jobShiftRef: map['job_shift_ref'],
          workerID: map['worker_ref']?.id ?? "",
        );
      } on Exception catch (e) {
        print("WorkerLogModel.fromMap error $e");
      }
    }
    return null;
  }
}

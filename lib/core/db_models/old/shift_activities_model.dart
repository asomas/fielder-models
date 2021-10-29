import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/schema/shift_actvities_schema.dart';
import 'package:fielder_models/core/db_models/old/shift_pattern_data_model.dart';
import 'package:flutter/cupertino.dart';

class ShiftActivitiesModel {
  String docID;
  DateTime clockInTime;
  GeoPoint clockInLocation;
  DateTime clockOutTime;
  DateTime shiftDate;
  GeoPoint clockOutLocation;
  DocumentReference shiftPatternRef;
  bool approved;
  DocumentReference approvedBy;
  ShiftPatternDataModel shiftPatternDataModel;
  DateTime approvedTime;
  DocumentReference workerRef;
  bool clocked;
  bool awaitingApproval;
  bool needsAttention;
  bool dismissible;
  bool clockedInLate;
  bool clockedInEarly;
  bool clockedInFaraway;
  bool clockedOutLate;
  bool clockedOutEarly;
  bool clockedOutFaraway;
  DateTime updatedAt;
  String shiftActivityReferenceId;

  ShiftActivitiesModel({
    this.clockInTime,
    this.clockInLocation,
    this.clockOutTime,
    this.clockOutLocation,
    this.shiftDate,
    this.docID,
    this.shiftPatternRef,
    this.approved = false,
    this.approvedBy,
    this.approvedTime,
    this.shiftPatternDataModel,
    this.workerRef,
    this.clocked = false,
    this.awaitingApproval = false,
    this.clockedInEarly,
    this.clockedInFaraway,
    this.clockedInLate,
    this.clockedOutEarly,
    this.clockedOutFaraway,
    this.clockedOutLate,
    this.dismissible,
    this.needsAttention,
    this.updatedAt,
    this.shiftActivityReferenceId,
  });

  factory ShiftActivitiesModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      try {
        final DocumentReference _shiftPatternRef =
            map[ShiftActivitiesSchema.shiftPatternRef];
        final DocumentReference _workerRef =
            map[ShiftActivitiesSchema.workerRef];
        final DocumentReference _approvedBy =
            map[ShiftActivitiesSchema.approvedBy];
        final GeoPoint _clockInLocation =
            map[ShiftActivitiesSchema.clockInLocation];
        final GeoPoint _clockOutLocation =
            map[ShiftActivitiesSchema.clockOutLocation];
        final Timestamp _clockInTimeStamp =
            map[ShiftActivitiesSchema.clockInTime];
        final Timestamp _clockOutTimeStamp =
            map[ShiftActivitiesSchema.clockOutTime];
        final Timestamp _shiftPatternDateTimeStamp =
            map[ShiftActivitiesSchema.shiftDate];
        final Timestamp _approvedTimeTimeStamp =
            map[ShiftActivitiesSchema.approveTime];
        final Timestamp _updatedatTimeStamp =
            map[ShiftActivitiesSchema.updatedAt];
        final bool _approved = map[ShiftActivitiesSchema.approved];
        final bool _clocked = map[ShiftActivitiesSchema.clocked];
        final bool _awaitingApproval =
            map[ShiftActivitiesSchema.awaitingApproval];
        final bool _needsAttention = map[ShiftActivitiesSchema.needsAttention];
        final bool _dismissible = map[ShiftActivitiesSchema.dismissible];
        final bool _clockInLate = map[ShiftActivitiesSchema.clockedInLate];
        final bool _clockInEarly = map[ShiftActivitiesSchema.clockedInEarly];
        final bool _clockInFarAway =
            map[ShiftActivitiesSchema.clockedInFaraway];
        final bool _clockOutLate = map[ShiftActivitiesSchema.clockedOutLate];
        final bool _clockOutEarly = map[ShiftActivitiesSchema.clockedOutEarly];
        final bool _clockOutFarAway =
            map[ShiftActivitiesSchema.clockedOutFaraway];
        final String _shiftActivityReferenceId =
            map[ShiftActivitiesSchema.shiftActivityReferenceId];

        final ShiftPatternDataModel shiftPatternDataModel =
            map[ShiftActivitiesSchema.shiftPatternData] != null
                ? ShiftPatternDataModel.fromMap(
                    map: map[ShiftActivitiesSchema.shiftPatternData],
                    docID: _shiftPatternRef.id)
                : null;

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
        DateTime _approvedTimeDateTime;
        if (_approvedTimeTimeStamp != null) {
          _approvedTimeDateTime = DateTime.fromMillisecondsSinceEpoch(
            _approvedTimeTimeStamp.millisecondsSinceEpoch,
          );
        }
        DateTime _updatedAtTimeDateTime;
        if (_updatedatTimeStamp != null) {
          _updatedAtTimeDateTime = DateTime.fromMillisecondsSinceEpoch(
            _updatedatTimeStamp.millisecondsSinceEpoch,
          );
        }

        return ShiftActivitiesModel(
          docID: docID,
          clockInTime: _clockInDateTime,
          clockInLocation: _clockInLocation,
          clockOutTime: _clockOutDateTime,
          shiftDate: _shiftPatternDateTime,
          clockOutLocation: _clockOutLocation,
          shiftPatternRef: _shiftPatternRef,
          approvedTime: _approvedTimeDateTime,
          approvedBy: _approvedBy,
          approved: _approved,
          shiftPatternDataModel: shiftPatternDataModel,
          workerRef: _workerRef,
          clocked: _clocked,
          awaitingApproval: _awaitingApproval,
          updatedAt: _updatedAtTimeDateTime,
          needsAttention: _needsAttention,
          dismissible: _dismissible,
          clockedInEarly: _clockInEarly,
          clockedInLate: _clockInLate,
          clockedInFaraway: _clockInFarAway,
          clockedOutEarly: _clockOutEarly,
          clockedOutLate: _clockOutLate,
          clockedOutFaraway: _clockOutFarAway,
          shiftActivityReferenceId: _shiftActivityReferenceId,
        );
      } on Exception catch (e) {
        print("ShiftActivitiesModel.fromMap error $e");
      }
    }
    return null;
  }
}

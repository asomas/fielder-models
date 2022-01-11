import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/schema/break_schema.dart';

class BreakModel {
  DateTime startTime;
  DateTime endTime;
  int breakLength;
  bool earlyStop;

  BreakModel({this.startTime, this.endTime, this.breakLength, this.earlyStop});

  factory BreakModel.fromMap(Map map) {
    try {
      return BreakModel(
          startTime: (map[BreakSchema.startTime] as Timestamp)?.toDate(),
          endTime: (map[BreakSchema.endTime] as Timestamp)?.toDate(),
          breakLength: map[BreakSchema.duration],
          earlyStop: map[BreakSchema.earlyStop] ?? false);
    } catch (e, s) {
      print('break model catch_____${e}______$s');
      return null;
    }
  }
}

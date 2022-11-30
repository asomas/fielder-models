import 'package:fielder_models/core/db_models/old/slot_model.dart';
import 'package:flutter/cupertino.dart';

class DateAndSlotsModel {
  final DateTime dt;
  final List<SlotModel> slots;
  bool disabled;
  int totalTimeRows;

  DateAndSlotsModel({@required this.dt, this.slots, this.disabled = false, this.totalTimeRows = 1});
}

class SlotGroupModel {
  String jobId;
  String workerId;
  String locationName;
  int rowIndex;

  SlotGroupModel({@required this.jobId, @required this.workerId, @required this.locationName, @required this.rowIndex});

  Map toJson() {
    return {'job_id': jobId, 'worker_id': workerId, 'location_name': locationName, 'row_index': rowIndex};
  }

  @override
  bool operator ==(other) {
    return this.jobId == other.jobId && this.workerId == other.workerId && this.locationName == other.locationName;
  }
}

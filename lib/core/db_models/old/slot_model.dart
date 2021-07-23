import 'package:fielder_models/core/db_models/old/shift_activities_model.dart';
import 'package:fielder_models/core/db_models/old/shift_pattern_data_model.dart';
import 'package:fielder_models/core/enums/slot_status_enums.dart';

class SlotModel {
  final String shiftId;
  final DateTime startTime;
  final DateTime endTime;
  final String slotText;
  String workerAvatarUrl;
  final String workerId;
  final String workerName;
  final DateTime weekDay;
  final SlotStatusIcon slotStatusIcon;
  final ShiftPatternDataModel shiftPatternDataModel;
  final ShiftActivitiesModel shiftActivitiesModel;
  final bool isUnavailable;

  SlotModel({
    this.shiftId,
    this.slotText = '',
    this.workerAvatarUrl,
    this.startTime,
    this.endTime,
    this.workerId,
    this.workerName = '',
    this.weekDay,
    this.shiftPatternDataModel,
    this.shiftActivitiesModel,
    this.slotStatusIcon = SlotStatusIcon.Inactive,
    this.isUnavailable = false,
  });

  @override
  bool operator ==(other) {
    return "${this.shiftId}" == "${other.shiftId}";
  }

  @override
  int get hashCode => super.hashCode;
}

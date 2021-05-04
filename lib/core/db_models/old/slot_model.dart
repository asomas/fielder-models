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
      this.slotStatusIcon = SlotStatusIcon.Inactive,
      this.isUnavailable = false,
      });

  @override
  bool operator ==(other) {
    return "${this.shiftId}-${this.slotStatusIcon}" ==
        "${other.shiftId}-${other.slotStatusIcon}";
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;


}

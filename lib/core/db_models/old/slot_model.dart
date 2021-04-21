
import 'package:fielder_models/core/constants/asset_constants.dart';
import 'package:fielder_models/core/enums/enums.dart';
import 'package:fielder_models/core/enums/slot_status_enums.dart';

class SlotModel {
  final String assignmentId;
  final int startHour;
  final int endHour;
  final int startMin;
  final int endMin;
  final SlotStatus slotStatus; //TODO REMOVE AFTER REFACTOR
  final String profileName;
  final String jobTitle;
  final String slotContentText;
  final String workerAvatarUrl;
  final String statusAssetName;
  final bool assigned;
  final String jobId;
  final DateTime weekDay;
  final String workerId;
  final bool recurring;
  final String shiftPatternTitle;
  final String slotTypeImage;
  final SlotStatusIcon slotStatusIcon;
  final String location;
  final double latitude;
  final double longitude;
  final double clockInLatitude;
  final double clockInLongitude;
  final double clockOutLatitude;
  final double clockOutLongitude;
  final DateTime clockInTime;
  final DateTime clockOutTime;
  final String organisationCompanyName;
  final bool isUnavailable;

  SlotModel(
      {this.assignmentId,
      this.workerId,
      this.profileName = '',
      this.jobTitle = '',
      this.slotContentText = '',
      this.workerAvatarUrl = '',
      this.endHour,
      this.startHour,
      this.startMin,
      this.endMin,
      this.slotStatus = SlotStatus.Empty,
      this.statusAssetName = '',
      this.assigned = false,
      this.jobId,
      this.weekDay,
      this.shiftPatternTitle,
      this.slotTypeImage = AssetsConstants.inactiveJobIcon,
      this.slotStatusIcon = SlotStatusIcon.Inactive,
      this.recurring = false,
      this.location,
      this.latitude,
      this.longitude,
      this.clockInLatitude,
      this.clockInLongitude,
      this.clockOutLatitude,
      this.clockOutLongitude,
      this.clockInTime,
      this.clockOutTime,
      this.organisationCompanyName = "",
      this.isUnavailable = false
      });
}

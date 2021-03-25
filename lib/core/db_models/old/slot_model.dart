
import 'package:fielder_models/core/constants/asset_constants.dart';
import 'package:fielder_models/core/enums/enums.dart';
import 'package:fielder_models/core/enums/slot_status_enums.dart';

class SlotModel {
  final String assignmentID;
  final int startHour;
  final int endHour;
  final int startMin;
  final int endMin;
  final SlotStatus slotStatus;
  final String profileName;
  final String jobTitle;
  final String slotContentText;
  final String picUrl;
  final String statusAssetName;
  final bool assigned;
  final String jobID;
  final DateTime weekDay;
  final bool recurring;
  final String shiftTitle;
  final String slotTypeImage;
  final SlotIconStatus slotIconStatus;
  final String location;
  final double latitude;
  final double longitude;
  final double clockInLatitude;
  final double clockInLongitude;
  final double clockOutLatitude;
  final double clockOutLongitude;
  final DateTime clockInTime;
  final DateTime clockOutTime;
  final String organisationName;

  SlotModel(
      {this.assignmentID,
      this.profileName = '',
      this.jobTitle = '',
      this.slotContentText = '',
      this.picUrl = '',
      this.endHour,
      this.startHour,
      this.startMin,
      this.endMin,
      this.slotStatus = SlotStatus.Empty,
      this.statusAssetName = '',
      this.assigned = false,
      this.jobID,
      this.weekDay,
      this.shiftTitle,
      this.slotTypeImage = AssetsConstants.inactiveJobIcon,
      this.slotIconStatus = SlotIconStatus.Inactive,
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
      this.organisationName = ""
      });
}

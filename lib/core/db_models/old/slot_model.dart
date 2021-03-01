import 'package:fielder_models/core/constants/asset_constants.dart';
import 'package:fielder_models/core/enums/enums.dart';

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
      this.slotTypeImage = AssetsConstants.inactiveJobIcon, // Asset is available is base project
      this.recurring = false});
}

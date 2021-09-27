import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/old/schema/right_to_work_schema.dart';
import 'package:fielder_models/core/enums/enums.dart';

class RightToWork {
  RightToWorkFlow verificationFlow;
  RightToWorkVerificationStatus verificationStatus;
  bool submitted;
  String shareCode;

  RightToWork(
      {this.verificationFlow,
      this.verificationStatus,
      this.submitted,
      this.shareCode});

  factory RightToWork.fromMap(Map map) {
    try {
      return RightToWork(
          verificationFlow: map.containsKey(RightToWorkSchema.verificationPath)
              ? EnumHelpers.rightToWorkFlowFromString(
                  map[RightToWorkSchema.verificationPath])
              : RightToWorkFlow.None,
          verificationStatus: map.containsKey(RightToWorkSchema.status)
              ? EnumHelpers.rightToWorkVerificationStatusFromString(
                  map[RightToWorkSchema.status])
              : RightToWorkVerificationStatus.None,
          submitted: map[RightToWorkSchema.submitted] ?? false,
          shareCode: map[RightToWorkSchema.shareCode]);
    } catch (e, s) {
      print('right to work model catch $e, $s');
      return null;
    }
  }
}

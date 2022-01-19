import 'package:fielder_models/core/db_models/old/schema/agora_details_schema.dart';

class AgoraDetailsModel {
  String appId;
  String channelName;
  int uid;
  String token;

  AgoraDetailsModel({this.appId, this.channelName, this.uid, this.token});

  factory AgoraDetailsModel.fromMap(Map map) {
    try {
      return AgoraDetailsModel(
        appId: map[AgoraDetailsSchema.appId],
        channelName: map[AgoraDetailsSchema.channelName],
        uid: map[AgoraDetailsSchema.uid],
        token: map[AgoraDetailsSchema.token],
      );
    } catch (e, s) {
      print('agora model parsing catch $e, $s');
      return null;
    }
  }
}

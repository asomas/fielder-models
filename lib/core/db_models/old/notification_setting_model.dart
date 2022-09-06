import 'package:fielder_models/core/db_models/old/schema/notification_setting_schema.dart';

class NotificationSettingModel {
  Map<String, NotificationTypeModel> notificationsType;

  NotificationSettingModel({
    this.notificationsType,
  });

  static NotificationSettingModel init() {
    return NotificationSettingModel(notificationsType: {
      NotificationSettingSchema.interviewCancelled: NotificationTypeModel(),
      NotificationSettingSchema.interviewScheduled: NotificationTypeModel(),
      NotificationSettingSchema.invitationStatusChanged:
          NotificationTypeModel(),
      NotificationSettingSchema.offerStatusChanged: NotificationTypeModel(),
      NotificationSettingSchema.completedShiftAwaitingApproval:
          NotificationTypeModel(),
      NotificationSettingSchema.lateShiftClockin: NotificationTypeModel(),
    });
  }

  factory NotificationSettingModel.fromMap(Map map) {
    try {
      Map<String, NotificationTypeModel> initMap = init().notificationsType;
      if (map.containsKey(NotificationSettingSchema.notifications)) {
        NotificationSettingModel model = NotificationSettingModel(
          notificationsType: map[NotificationSettingSchema.notifications]
              ?.map<String, NotificationTypeModel>(
            (String key, dynamic value) => MapEntry(
              key,
              NotificationTypeModel.fromMap(value),
            ),
          ) as Map<String, NotificationTypeModel>,
        );
        initMap.entries.forEach((element) {
          model.notificationsType.putIfAbsent(element.key, () => element.value);
        });
        return model;
      }
      return null;
    } catch (e, s) {
      print("notification setting model ctach______$e,____$s");
      return null;
    }
  }

  Map<String, dynamic> toJson() => {
        NotificationSettingSchema.notifications:
            notificationsType.map((key, value) => MapEntry(key, value.toJson()))
      };
}

class NotificationTypeModel {
  bool email;
  bool sms;
  bool push;

  NotificationTypeModel(
      {this.email = false, this.push = false, this.sms = false});

  factory NotificationTypeModel.fromMap(Map type) {
    try {
      return NotificationTypeModel(
        email: type[NotificationSettingSchema.email] ?? false,
        sms: type[NotificationSettingSchema.sms] ?? false,
        push: type[NotificationSettingSchema.push] ?? false,
      );
    } catch (e, s) {
      print("notification type model ctach______$e,____$s");
      return null;
    }
  }

  Map<String, dynamic> toJson() => {
        NotificationSettingSchema.email: email,
        NotificationSettingSchema.sms: sms,
        NotificationSettingSchema.push: push,
      };
}

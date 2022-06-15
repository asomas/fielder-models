import 'package:fielder_models/core/db_models/old/schema/notification_setting_schema.dart';

class NotificationSettingModel {
  NotificationTypeModel interviewScheduled;
  NotificationTypeModel interviewCancelled;
  NotificationTypeModel invitationStatusChanged;
  NotificationTypeModel offerStatusChanged;
  NotificationTypeModel completedShiftWaitingApproval;

  NotificationSettingModel({
    this.interviewScheduled,
    this.completedShiftWaitingApproval,
    this.interviewCancelled,
    this.invitationStatusChanged,
    this.offerStatusChanged,
  });

  factory NotificationSettingModel.fromMap(Map map) {
    try {
      return NotificationSettingModel(
        interviewCancelled: NotificationTypeModel.fromMap(
            map[NotificationSettingSchema.interviewCancelled]),
        interviewScheduled: NotificationTypeModel.fromMap(
            map[NotificationSettingSchema.interviewScheduled]),
        invitationStatusChanged: NotificationTypeModel.fromMap(
            map[NotificationSettingSchema.invitationStatusChanged]),
        offerStatusChanged: NotificationTypeModel.fromMap(
            map[NotificationSettingSchema.offerStatusChanged]),
        completedShiftWaitingApproval: NotificationTypeModel.fromMap(
            map[NotificationSettingSchema.completedShiftWaitingApproval]),
      );
    } catch (e, s) {
      print("notification setting model ctach______${e},____$s");
      return null;
    }
  }

  Map<String, dynamic> toJson() => {
        NotificationSettingSchema.notifications: {
          NotificationSettingSchema.interviewCancelled:
              interviewCancelled.toJson(),
          NotificationSettingSchema.interviewScheduled:
              interviewScheduled.toJson(),
          NotificationSettingSchema.invitationStatusChanged:
              invitationStatusChanged.toJson(),
          NotificationSettingSchema.offerStatusChanged:
              offerStatusChanged.toJson(),
          NotificationSettingSchema.completedShiftWaitingApproval:
              completedShiftWaitingApproval.toJson(),
        }
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
      print("notification type model ctach______${e},____$s");
      return null;
    }
  }

  Map<String, dynamic> toJson() => {
        NotificationSettingSchema.email: email,
        NotificationSettingSchema.sms: sms,
        NotificationSettingSchema.push: push,
      };
}

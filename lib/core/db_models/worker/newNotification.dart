import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/worker/schema/newsNotificationSchema.dart';
import 'package:fielder_models/core/enums/enums.dart';

class NewsScreenRedirects {
  static const String profile = "Profile";
}

class NewsNotification {
  String id;
  String articleUrl;
  String body;
  Timestamp createdAt;
  bool dismissed;
  Timestamp expiresAt;
  String image;
  String messageId;
  bool read;
  Timestamp readAt;
  String subtitle;
  String title;
  String type;
  bool withNotification;
  bool expanded;
  bool nonDismissible;
  String screen;
  String actionButtonText;
  NewsCardType cardType;

  NewsNotification({
    this.id,
    this.articleUrl,
    this.body,
    this.createdAt,
    this.dismissed,
    this.expiresAt,
    this.image,
    this.messageId,
    this.read,
    this.readAt,
    this.subtitle,
    this.title,
    this.type,
    this.withNotification,
    this.nonDismissible,
    this.expanded,
    this.screen,
    this.actionButtonText,
    this.cardType,
  });

  factory NewsNotification.fromJson(Map<String, dynamic> json, String docId) =>
      NewsNotification(
          id: docId,
          screen: json[NewsNotificationSchema.screen],
          actionButtonText:
              json[NewsNotificationSchema.actionButtonText] == null ||
                      json[NewsNotificationSchema.actionButtonText].isEmpty
                  ? "Let's Go!"
                  : json[NewsNotificationSchema.actionButtonText],
          articleUrl: json[NewsNotificationSchema.articleUrl] != null
              ? json[NewsNotificationSchema.articleUrl]
              : "",
          body: json[NewsNotificationSchema.body] != null
              ? json[NewsNotificationSchema.body]
              : "",
          createdAt: json[NewsNotificationSchema.createdAt] != null
              ? json[NewsNotificationSchema.createdAt]
              : Timestamp.fromDate(DateTime.now()),
          dismissed: json[NewsNotificationSchema.dismissed] != null
              ? json[NewsNotificationSchema.dismissed]
              : Timestamp.fromDate(DateTime.now()),
          expiresAt: json[NewsNotificationSchema.expiresAt] != null
              ? json[NewsNotificationSchema.expiresAt]
              : Timestamp.fromDate(DateTime.now()),
          image: json[NewsNotificationSchema.image] != null
              ? json[NewsNotificationSchema.image]
              : "",
          messageId: json[NewsNotificationSchema.messageId] != null
              ? json[NewsNotificationSchema.messageId]
              : "",
          read: json[NewsNotificationSchema.read] != null
              ? json[NewsNotificationSchema.read]
              : false,
          readAt: json[NewsNotificationSchema.readAt] != null
              ? json[NewsNotificationSchema.readAt]
              : Timestamp.fromDate(DateTime.now()),
          subtitle: json[NewsNotificationSchema.subTitle] != null
              ? json[NewsNotificationSchema.subTitle]
              : "",
          title: json[NewsNotificationSchema.title] != null
              ? json[NewsNotificationSchema.title]
              : "",
          type: json[NewsNotificationSchema.type] != null
              ? json[NewsNotificationSchema.type]
              : "",
          expanded: json[NewsNotificationSchema.expanded] ?? false,
          nonDismissible: json[NewsNotificationSchema.nonDismissible] ?? false,
          withNotification: json[NewsNotificationSchema.withNotification] != null
              ? json[NewsNotificationSchema.withNotification]
              : false,
          cardType: EnumHelpers.newsCardTypeFomString(
              json[NewsNotificationSchema.type]));
}

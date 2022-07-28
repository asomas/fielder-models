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
  String icon;
  NewsCardType cardType;
  List<NewsCardButton> cardButtons;

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
    this.icon,
    this.cardType,
    this.cardButtons = const [],
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
          icon: json[NewsNotificationSchema.icon],
          expanded: json[NewsNotificationSchema.expanded] ?? false,
          nonDismissible: json[NewsNotificationSchema.nonDismissible] ?? false,
          withNotification:
              json[NewsNotificationSchema.withNotification] != null
                  ? json[NewsNotificationSchema.withNotification]
                  : false,
          cardType: EnumHelpers.newsCardTypeFomString(
            json[NewsNotificationSchema.type],
          ),
          cardButtons: json[NewsNotificationSchema.buttons] != null
              ? List<NewsCardButton>.from(json[NewsNotificationSchema.buttons]
                  .map((x) => NewsCardButton.fromMap(x)))
              : []);
}

class NewsCardButton {
  bool dismissOnPress;
  String buttonText;
  NewsCardAction cardAction;
  CardAction action;

  NewsCardButton(
      {this.dismissOnPress, this.buttonText, this.cardAction, this.action});

  factory NewsCardButton.fromMap(Map map) {
    try {
      NewsCardAction _cardAction;
      CardAction _action;
      if (map.containsKey(NewsNotificationSchema.action) &&
          map[NewsNotificationSchema.action] != null) {
        _cardAction = EnumHelpers.newsCardActionFromString(
            map[NewsNotificationSchema.action]
                [NewsNotificationSchema.actionName]);

        if (_cardAction == NewsCardAction.PostRequest) {
          _action = NewsCardPostRequestAction.fromMap(
              map[NewsNotificationSchema.action]);
        } else if (_cardAction == NewsCardAction.GetRequest) {
          _action = NewsCardGetRequestAction.fromMap(
              map[NewsNotificationSchema.action]);
        } else if (_cardAction == NewsCardAction.NavigateScreen) {
          _action = NewsCardNavigateScreenAction.fromMap(
              map[NewsNotificationSchema.action]);
        } else if (_cardAction == NewsCardAction.Browser) {
          _action = NewsCardOpenBrowserAction.fromMap(
              map[NewsNotificationSchema.action]);
        }
      }

      return NewsCardButton(
        dismissOnPress: map[NewsNotificationSchema.dismissOnPress],
        buttonText: map[NewsNotificationSchema.buttonText],
        cardAction: _cardAction,
        action: _action,
      );
    } catch (e, s) {
      print('card button catch____${e}____$s');
      return null;
    }
  }
}

abstract class CardAction {
  NewsCardAction get cardAction;
}

class NewsCardPostRequestAction extends CardAction {
  String url;
  Map<String, dynamic> payload;

  NewsCardPostRequestAction({this.url, this.payload});

  factory NewsCardPostRequestAction.fromMap(Map map) {
    try {
      return NewsCardPostRequestAction(
        //cardAction: NewsCardAction.PostRequest,
        payload: map[NewsNotificationSchema.payload],
        url: map[NewsNotificationSchema.url],
      );
    } catch (e, s) {
      print('post action button catch____${e}____$s');
      return null;
    }
  }

  @override
  NewsCardAction get cardAction => NewsCardAction.PostRequest;
}

class NewsCardGetRequestAction extends CardAction {
  String url;

  NewsCardGetRequestAction({this.url});

  factory NewsCardGetRequestAction.fromMap(Map map) {
    try {
      return NewsCardGetRequestAction(
        url: map[NewsNotificationSchema.url],
      );
    } catch (e, s) {
      print('get action button catch____${e}____$s');
      return null;
    }
  }

  @override
  NewsCardAction get cardAction => NewsCardAction.GetRequest;
}

class NewsCardNavigateScreenAction extends CardAction {
  String screenName;

  NewsCardNavigateScreenAction({this.screenName});

  factory NewsCardNavigateScreenAction.fromMap(Map map) {
    try {
      return NewsCardNavigateScreenAction(
        screenName: map[NewsNotificationSchema.screenName],
      );
    } catch (e, s) {
      print('screen action button catch____${e}____$s');
      return null;
    }
  }

  @override
  NewsCardAction get cardAction => NewsCardAction.NavigateScreen;
}

class NewsCardOpenBrowserAction extends CardAction {
  String url;

  NewsCardOpenBrowserAction({this.url});

  factory NewsCardOpenBrowserAction.fromMap(Map map) {
    try {
      return NewsCardOpenBrowserAction(
        url: map[NewsNotificationSchema.url],
      );
    } catch (e, s) {
      print('browser action button catch____${e}____$s');
      return null;
    }
  }

  @override
  NewsCardAction get cardAction => NewsCardAction.Browser;
}

import 'package:fielder_models/core/constants/app_strings.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/enums/enums.dart';

class UserPromptSchema {
  static const String title = 'title';
  static const String subTitle = 'subtitle';
  static const String type = 'type';
  static const String readMoreButtonText = 'read_more_button_text';
  static const String readMoreActionUrl = 'read_more_action_url';
  static const String userPrompt = 'user_prompt';
}

class UserPrompt {
  String title;
  String subTitle;
  OverlayType type;
  String readMoreButtonText;
  String readMoreActionUrl;
  bool showReadMore;

  UserPrompt(
      {this.title,
      this.subTitle,
      this.type,
      this.readMoreButtonText,
      this.readMoreActionUrl,
      this.showReadMore = false});

  factory UserPrompt.fromMap(Map map) {
    if (map != null && map.isNotEmpty) {
      try {
        return UserPrompt(
          title:
              map[UserPromptSchema.title] ?? AppStrings.oopsSomethingWentWrong,
          subTitle:
              map[UserPromptSchema.subTitle] ?? AppStrings.errorHelpingDetail,
          type: map[UserPromptSchema.type] != null
              ? EnumHelpers.overlayTypeFromString(map[UserPromptSchema.type])
              : OverlayType.ERROR,
          readMoreButtonText: map[UserPromptSchema.readMoreButtonText],
          readMoreActionUrl: map[UserPromptSchema.readMoreActionUrl],
          showReadMore: (map[UserPromptSchema.readMoreButtonText] != null &&
                  map[UserPromptSchema.readMoreButtonText]
                      .toString()
                      .isNotEmpty) &&
              (map[UserPromptSchema.readMoreActionUrl] != null &&
                  map[UserPromptSchema.readMoreActionUrl]
                      .toString()
                      .isNotEmpty),
        );
      } catch (e, s) {
        print("user prompt catch_____${e}_____$s");
        return null;
      }
    }
    return null;
  }
}

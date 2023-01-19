import 'package:flutter/material.dart';

class HelpGuideModel {
  String mainVideo;
  String instructionText;
  List<HelpStepsModel> helpSteps;

  HelpGuideModel({this.mainVideo, this.instructionText, this.helpSteps});

  factory HelpGuideModel.fromJson(Map json) {
    try {
      return HelpGuideModel(
        mainVideo: json['main_video'],
        instructionText: json['instruction_text'],
        helpSteps: json['steps'] != null
            ? (json['steps'] as List)
                    .map((e) => HelpStepsModel.fromJson(e))
                    ?.toList() ??
                []
            : [],
      );
    } catch (e, s) {
      print('help guide model catch____${e}____$s');
      return null;
    }
  }
}

class HelpStepsModel {
  String title;
  String subtitle;
  String videoUrl;

  HelpStepsModel(
      {@required this.title, @required this.subtitle, this.videoUrl});

  factory HelpStepsModel.fromJson(Map json) {
    try {
      return HelpStepsModel(
        title: json['title'],
        subtitle: json['subtitle'],
        videoUrl: json['video'],
      );
    } catch (e, s) {
      print('help step model catch____${e}____$s');
      return null;
    }
  }
}

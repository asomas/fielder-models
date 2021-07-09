import 'package:flutter/material.dart';

class OverlayTabsString{
  static const String label = "label";
  static const String icon = "icon";
  static const String view = "view";
  static const String isDisabled = "isDisabled";
  static const String isNextDisabled = "isNextDisabled";
  static const String isBackDisabled = "isBackDisabled";
  static const String key = "key";
}

class OverlayTabsModel {
  String label;
  String icon;
  Widget view;
  bool isDisabled; // To disable click action on tab
  bool isNextDisabled; // To disable going forward from the current tab
  bool isBackDisabled; // To disable going back from the current tab
  Key key;

  OverlayTabsModel(
      {this.key,
      @required this.label,
      this.icon,
      this.isDisabled = false,
      this.isNextDisabled = false,
      this.isBackDisabled = false,
      @required this.view})
      : assert(label != null && view != null);

  factory OverlayTabsModel.fromJson(Map json){
    return OverlayTabsModel(
      label: json[OverlayTabsString.label],
      isBackDisabled: json[OverlayTabsString.isBackDisabled],
      isNextDisabled: json[OverlayTabsString.isNextDisabled],
      isDisabled: json[OverlayTabsString.isDisabled],
      icon: json[OverlayTabsString.icon],
      view: json[OverlayTabsString.view] as Widget,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      OverlayTabsString.label : label,
      OverlayTabsString.icon : icon,
      OverlayTabsString.view : view,
      OverlayTabsString.isDisabled : isDisabled,
      OverlayTabsString.isNextDisabled : isNextDisabled,
      OverlayTabsString.isBackDisabled : isBackDisabled,
      OverlayTabsString.key : key,
    };
  }
}

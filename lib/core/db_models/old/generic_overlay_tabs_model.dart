import 'package:flutter/material.dart';

class OverlayTabsModel {
  String label;
  String icon;
  Widget view;
  bool isDisabled; // To disable click action on tab
  bool isNextDisabled; // To disable going forward from the current tab
  bool isBackDisabled; // To disable going back from the current tab
  Key key;
  double width;
  Function onTap;

  OverlayTabsModel({
    this.key,
    @required this.label,
    this.icon,
    this.isDisabled = false,
    this.isNextDisabled = false,
    this.isBackDisabled = false,
    this.width = 124,
    @required this.view,
    this.onTap,
  }) : assert(label != null && view != null);
}

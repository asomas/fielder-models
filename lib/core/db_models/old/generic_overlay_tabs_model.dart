import 'package:flutter/material.dart';

class OverlayTabsModel {
  String label;
  String icon;
  Widget view;
  bool isDisabled; // To disable click action on tab
  bool isNextDisabled; // To disable going forward from the current tab
  bool isBackDisabled; // To disable going back from the current tab

  OverlayTabsModel(
      {@required this.label,
      this.icon,
      this.isDisabled = false,
      this.isNextDisabled = false,
      this.isBackDisabled = false,
      @required this.view})
      : assert(label != null && view != null);
}

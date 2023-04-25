import 'package:fielder_models/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PageStatus {
  final String name;
  final String url;
  final String status;
  Color statusColor;

  PageStatus({
    @required this.name,
    @required this.url,
    @required this.status,
    Color statusColor,
  }) {
    this.statusColor = statusColor ?? _getColorFromInstatusString(status);
  }

  factory PageStatus.fromJson(Map<String, dynamic> json) {
    return PageStatus(
      name: json['name'] as String,
      url: json['url'] as String,
      status: json['status'] as String,
    );
  }

  Color _getColorFromInstatusString(String status) {
    switch (status) {
      case "HASISSUES":
        return AppColors.red;
      case "UNDERMAINTENANCE":
        return AppColors.orange;
      case "UP":
      default:
        return AppColors.iconColor;
    }
  }
}

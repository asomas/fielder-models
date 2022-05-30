import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/helpers/helpers.dart';
import 'package:fielder_models/core/db_models/old/schema/dashboard_stats_schema.dart';
import 'package:flutter/material.dart';

import '../../enums/enums.dart';

class DashboardStatsTrendModel {
  DateTime lastStoredDate;
  int count;
  Trending trend;

  DashboardStatsTrendModel(
      {@required this.lastStoredDate,
      @required this.count,
      @required this.trend});

  factory DashboardStatsTrendModel.fromMap(Map map) {
    if (map != null && map.isNotEmpty) {
      try {
        return DashboardStatsTrendModel(
            lastStoredDate:
                DateTime.tryParse(map[DashboardStatsSchema.lastStoredDate]),
            count: map[DashboardStatsSchema.count],
            trend: EnumHelpers.trendingFromString(
                map[DashboardStatsSchema.trend]));
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      DashboardStatsSchema.lastStoredDate: lastStoredDate.toString(),
      DashboardStatsSchema.count: count,
      DashboardStatsSchema.trend: EnumHelpers.stringFromTrending(trend)
    };
  }

  Trending getTrendFromCount(int newCount) {
    if (newCount > count) return Trending.Up;
    return Trending.Down;
  }

  static bool canStoreTrend(
      {DateTime trendLastStoreDate, int oldValue, int newValue}) {
    if (trendLastStoreDate == null) {
      return true;
    } else {
      try {
        return Helpers.getDate(trendLastStoreDate)
            .isBefore(Helpers.getDate(DateTime.now()));
      } catch (e) {
        return true;
      }
    }
  }
}

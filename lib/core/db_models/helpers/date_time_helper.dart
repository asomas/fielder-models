import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class DateTimeHelper {
  DateTimeHelper() {
    tz.initializeTimeZones();
  }

  static String dateToString(DateTime dateTime) {
    if (dateTime != null) {
      return DateFormat("yyyy-MM-dd").format(dateTime);
    }
    return null;
  }

  static DateTime getDate(DateTime dateTime) =>
      DateTime(dateTime?.year, dateTime?.month, dateTime?.day);

  static Color hexToColor(String code) {
    if (code?.isNotEmpty == true) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }
    return Color(0xFF0288D1); // blue;
  }

  static Timestamp timeStampFromString(date) {
    if (date is String) {
      if (date != null && date.isNotEmpty) {
        String split = date.toString().split("T")[0];
        return Timestamp.fromDate(DateTime.parse(split));
      }
    } else if (date is Timestamp) {
      return date;
    }
    return null;
  }

  DateTime convertToUKTime(DateTime dateTime) {
    try {
      if (dateTime != null) {
        var detroit = tz.getLocation('Europe/London');
        return tz.TZDateTime.from(dateTime, detroit);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}

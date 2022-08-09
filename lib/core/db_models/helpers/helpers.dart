import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helpers {
  static DocumentReference documentReferenceFromString(
      String stringDocumentReference) {
    List<String> splitReference = stringDocumentReference.split("/");
    return FirebaseFirestore.instance
        .collection(splitReference[0])
        .doc(splitReference[1]);
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

  static bool isUrl(String url) {
    String pattern =
        r"^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$";
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(url)) {
      return true;
    } else {
      return false;
    }
  }

  static bool isYoutubeLink(String link) {
    String pattern =
        r"^((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?$";
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(link)) {
      return true;
    } else {
      return false;
    }
  }
}

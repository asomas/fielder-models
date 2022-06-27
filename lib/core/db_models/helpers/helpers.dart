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
}

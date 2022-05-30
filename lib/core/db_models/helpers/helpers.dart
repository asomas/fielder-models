import 'package:cloud_firestore/cloud_firestore.dart';
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
}

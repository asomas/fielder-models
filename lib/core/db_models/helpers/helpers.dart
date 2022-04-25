import 'package:cloud_firestore/cloud_firestore.dart';

class Helpers {
  static DocumentReference documentReferenceFromString(
      String stringDocumentReference) {
    List<String> splitReference = stringDocumentReference.split("/");
    return FirebaseFirestore.instance
        .collection(splitReference[0])
        .doc(splitReference[1]);
  }
}

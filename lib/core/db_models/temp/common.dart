import 'package:cloud_firestore/cloud_firestore.dart';

enum AcceptanceStatus { ACCEPTED, DECLINED, PENDING }

enum Roles { OWNER, MANAGER, SUPERVISOR }

class AddressBasic {
  String county;
  String country;
  String line1;
  String line2;
  String postCode;
  String poBox;
  String town;
}

class VerifiedBase {
  Timestamp dov;
  bool isVerified;
  String source;
}

class VerifiedString extends VerifiedBase {
  String value;
}

class VerifiedDate extends VerifiedBase {
  String value;
}

class VerifiedDateTime extends VerifiedBase {
  Timestamp value;
}

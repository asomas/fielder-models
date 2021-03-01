import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/temp/common.dart';

// collection name: employer_user
class EmployerUser {
  String name; // max value 156
  String email; // valid email
  Map<String, UserOrganisation> organisations; // id of map should be an Id of employer in employer collection
  Timestamp dateCreated;// FirestoreTimeStamp

}

// Validate all the condition inside fromMap if everything is good
//check dependency no need to don manually
// Make the json manually

//Read json_annotation
//https://pub.dev/packages/json_schema

// helper
class UserOrganisation{
  String name;  //max length 75
  AcceptanceStatus status; // check into fromMap and return the StatusEnums
  Roles role; // check into fromMap and return the RolesEnum
}

class Contact {
  String name;  //max length
  String phone; //validate
  String email; //validate
}


// Collection name: employers
class Employer {
  String companyName; //max length 75
  String brandColor; // Validate with # symbol with six digit
}

class BillingContact extends Contact {
// Document has fixed ID, billing_contact, inside Subcollection called company_info.  So the complete path to this
// document is  employers/employer_id/company_info/billing_contact
// note, inherits fields from contacts Serialiser

}
class GeneralContact extends Contact {
// Document has fixed ID, general_contact, inside Subcollection called company_info.  So the complete path to this
// document is  employers/employer_id/company_info/general_contact
// note, inherits fields e.g. email from contacts Serialiser
  String website; // Validate URL
}

class SICCode {
  String code; // max length
  String description; // max length 200
}

// Helper
class Company {
  // Document has fixed ID, main, inside Subcollection called company_info.  So the complete path to this document is
  // employers/employer_id/company_info/main
  String name; //validate
  Timestamp incorporationDate; // Validate
  String registrationNumber; //min & max length 8
  String sicCode;
  List<Director> directors;

  AddressBasic address;
  Timestamp lastUpdated;
  Timestamp lastFilingDate;
  String vatNumber;
  Timestamp vatRegistrationDate;
}

// Helper
class Director{
  String name;
  String appointmentDate;
}

class UpdateUser {
  String name;
}



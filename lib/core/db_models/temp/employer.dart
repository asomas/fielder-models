import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/temp/common.dart';
import 'package:json_schema/json_schema.dart';

// collection name: employer_user
class EmployerUser {
  String name; // max value 156
  String email; // valid email
  var organizations = Map<String,
      UserOrganization>(); // id of map should be an Id of employer in employer collection
  Timestamp dateCreated; // FirestoreTimeStamp

  // Test Example
  String testJson =
      '{ "name": "Test", "email": "abc@test.com", "organizations": {"org1": {"name": "Deepak", "role": "", "status": '
      '""}}, '
      '"date_created": ""}';

  static EmployerUser fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    print("inside map ${map}");
    //print("organization ${map['organizations']}");
    var name = map['name'];
    print("name is ${name}");

    EmployerUser employerUser = EmployerUser();
    employerUser.name = map['name'];
    employerUser.email = map['email'];
    //employerUser.organizations = map['organizations'];
    var data = map['organizations'] as Map;

    if (data != null) {
      data.forEach((key, value) {
        var user = UserOrganization.fromMap(value);
        var data = {key.toString(): user};
        employerUser.organizations.addAll(data);
      });
    }
    employerUser.dateCreated = map['date_created'];
    print("employer is ${employerUser}");
    return employerUser;
  }

  Map toJson() =>
      {
        "name": name,
        "email": email,
        "organizations": organizations,
        "date_created": dateCreated,
      };
}

// Validate all the condition inside fromMap if everything is good
//check dependency no need to don manually
// Make the json manually

//Read json_annotation
//https://pub.dev/packages/json_schema

// helper
class UserOrganization {
  String name; //max length 75
  AcceptanceStatus status; // check into fromMap and return the StatusEnums
  Roles role; // check into fromMap and return the RolesEnum

  static UserOrganization fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    UserOrganization userOrganization = UserOrganization();
    userOrganization.name = map['name'];
    userOrganization.role = getRole(map['role']);
    userOrganization.status = getAcceptanceStatus(map['status']);
    return userOrganization;
  }

  static Roles getRole(String role) {
    Roles userRole = Roles.OWNER;
    if (role == 'owner') {
      userRole = Roles.OWNER;
    } else if (role == 'manager') {
      userRole = Roles.MANAGER;
    } else if (role == 'supervisor') {
      userRole = Roles.SUPERVISOR;
    }
    return userRole;
  }

  static AcceptanceStatus getAcceptanceStatus(String status) {
    AcceptanceStatus acceptanceStatus = AcceptanceStatus.ACCEPTED;
    if (status == 'accepted') {
      acceptanceStatus = AcceptanceStatus.ACCEPTED;
    } else if (status == 'declined') {
      acceptanceStatus = AcceptanceStatus.DECLINED;
    } else if (status == 'pending') {
      acceptanceStatus = AcceptanceStatus.PENDING;
    }
    return acceptanceStatus;
  }

  Map toJson() =>
      {
        "name": name,
        "role": role,
        "status": status,
      };
}

// Collection name: employers
class Employer {
  String companyName; //max length 75
  String brandColor; // Validate with # symbol with six digit

  static Employer fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    Employer employer = Employer();
    employer.companyName = map['company_name'];
    employer.brandColor = map['brand_color'];

    return employer;
  }

  Map toJson() =>
      {
        "company_name": companyName,
        "brand_color": brandColor,
      };
}

class Contact {
  String name; //max length
  String phone; //validate
  String email; //validate
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
class Director {
  String name;
  String appointmentDate;
}

class AddressBasic {
  String county;
  String country;
  String line1;
  String line2;
  String postCode;
  String poBox;
  String town;
}

// Helper
class Company {
  // Document has fixed ID, main, inside Subcollection called company_info.  So the complete path to this document is
  // employers/employer_id/company_info/main
  String name; //validate
  Timestamp incorporationDate; // Validate
  String registrationNumber; //min & max length 8
  List<SICCode> sicCodes;
  List<Director> directors;

  AddressBasic address;
  Timestamp lastUpdated;
  Timestamp lastFilingDate;
  String vatNumber;
  Timestamp vatRegistrationDate;
}

class UpdateUser {
  String name;
}

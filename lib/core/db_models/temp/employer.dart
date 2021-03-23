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

  Map toJson() => {
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
    } else if (role == "admin") {
      userRole = Roles.ADMIN;
    } else if (role == "hr") {
      userRole = Roles.HR;
    }

    return userRole;
  }

  static String getRoleString(Roles role) {
    String userRole = "owner";
    if (role == Roles.OWNER) {
      userRole = "owner";
    } else if (role == Roles.MANAGER) {
      userRole = "manager";
    } else if (role == Roles.SUPERVISOR) {
      userRole = "supervisor";
    } else if (role == Roles.ADMIN) {
      userRole = "admin";
    } else if (role == Roles.HR) {
      userRole = "hr";
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

  Map toJson() => {
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

  Map toJson() => {
        "company_name": companyName,
        "brand_color": brandColor,
      };
}

class Contact {
  String name = null; //max length
  String phone = null; //validate
  String email = null; //validate
}

class BillingContact extends Contact {
// Document has fixed ID, billing_contact, inside Subcollection called company_info.  So the complete path to this
// document is  employers/employer_id/company_info/billing_contact
// note, inherits fields from contacts Serialiser

  static BillingContact fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    BillingContact billingContact = BillingContact();
    billingContact.name = map['name'];
    billingContact.email = map['email'];
    billingContact.phone = map['phone'];

    return billingContact;
  }

  Map toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
      };
}

class GeneralContact extends Contact {
// Document has fixed ID, general_contact, inside Subcollection called company_info.  So the complete path to this
// document is  employers/employer_id/company_info/general_contact
// note, inherits fields e.g. email from contacts Serialiser
  String website = null; // Validate URL

  static GeneralContact fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    GeneralContact generalContact = GeneralContact();
    generalContact.name = map['name'];
    generalContact.email = map['email'];
    generalContact.phone = map['phone'];
    generalContact.website = map['website'];

    return generalContact;
  }

  Map toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "website": website,
      };
}

class SICCode {
  String code; // max length
  String description; // max length 200

  static SICCode fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    SICCode sicCode = SICCode();
    sicCode.code = map['code'];
    sicCode.description = map['description'];
    return sicCode;
  }
}

// Helper
class Director {
  String name;
  Timestamp appointmentDate;

  static Director fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    Director director = Director();
    director.name = map['name'];
    director.appointmentDate = map['appointment_date'];
    return director;
  }
}

class AddressBasic {
  String county;
  String country;
  String name;
  String street;
  String postCode;
  String poBox;
  String town;

  static AddressBasic fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    AddressBasic addressBasic = AddressBasic();
    addressBasic.county = map['county'];
    addressBasic.country = map['country'];
    addressBasic.name = map['name'];
    addressBasic.street = map['street'];
    addressBasic.postCode = map['postcode'];
    addressBasic.poBox = map['poBox'];
    addressBasic.town = map['town'];
    return addressBasic;
  }
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

  static Company fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Company company = Company();
    company.name = map['name'];
    company.incorporationDate = map['incorporation_date'];
    company.registrationNumber = map['registration_number'];
    company.sicCodes =
        List<SICCode>.from(map["sic_codes"].map((x) => SICCode.fromMap(x)));
    company.directors =
        List<Director>.from(map["directors"].map((x) => Director.fromMap(x)));

    company.address = AddressBasic.fromMap(map['address']);
    company.lastUpdated = map['last_updated'];
    company.lastFilingDate = map['last_filing_date'];
    company.vatNumber = map['vat_number'];
    company.vatRegistrationDate = map['vat_registration_date'];
    return company;
  }
}

class UpdateUser {
  String name;
}

class CompaniesResults {
  CompaniesResults({
    this.pageNumber,
    this.items,
  });

  int pageNumber;
  List<CompanyDetail> items;

  factory CompaniesResults.fromJson(Map<String, dynamic> json) =>
      CompaniesResults(
        pageNumber: json["page_number"],
        items: List<CompanyDetail>.from(
            json["items"].map((x) => CompanyDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page_number": pageNumber,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class CompanyDetail {
  CompanyDetail({
    this.companyNumber,
    this.title,
  });

  String companyNumber;
  String title;

  factory CompanyDetail.fromJson(Map<String, dynamic> json) => CompanyDetail(
        companyNumber: json["company_number"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "company_number": companyNumber,
        "title": title,
      };
}

class UsersList {
  UsersList({
    this.users,
  });

  List<UserDetail> users;

  factory UsersList.fromJson(Map<String, dynamic> json) => UsersList(
        users: json["users"] == null
            ? null
            : List<UserDetail>.from(
                json["users"].map((x) => UserDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": users == null
            ? null
            : List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class UserDetail {
  UserDetail({
    this.id,
    this.name,
    this.email,
    this.dateCreated,
    this.status,
    this.role,
    this.manager,
  });

  String id;
  String name;
  String email;
  DateTime dateCreated;
  AcceptanceStatus status;
  String role;
  String manager;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        status: json["status"] == null
            ? null
            : UserOrganization.getAcceptanceStatus(json['status']),
        role: json["role"] == null ? null : json["role"],
        manager: json["manager"] == null ? null : json["manager"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "date_created":
            dateCreated == null ? null : dateCreated.toIso8601String(),
        "status": status == null ? null : status,
        "role": role == null ? null : role,
        "manager": manager == null ? null : manager,
      };

  static Future<UserDetail> getUserDetails(DocumentReference ref,
      {String collection = "job_shifts"}) async {
    if (ref != null) {
      DocumentSnapshot ds = await FirebaseFirestore.instance
          .collection(collection)
          .doc(ref.id)
          .get();
      if (ds.exists && ds.data().length > 0) {
        Map json = ds.data();
        return UserDetail(
          id: ds.id,
          name: json["name"] ?? "",
          dateCreated: json["date_created"] == null
              ? null
              : DateTime.parse(json["date_created"]),
          email: json["email"] == null ? null : json["email"],
        );
      }
    }
    return null;
  }
}

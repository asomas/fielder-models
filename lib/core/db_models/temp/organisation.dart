import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/old/schema/organisation_user_schema.dart';
import 'package:fielder_models/core/db_models/temp/common.dart';

class OrganisationUserRelation {
  DocumentReference organisationRef;
  DocumentReference organisationUserRef;
  Roles role;
  AcceptanceStatus status;
  Organisation organisation;

  OrganisationUserRelation({
    this.organisationRef,
    this.organisationUserRef,
    this.role,
    this.status,
    this.organisation,
  });

  factory OrganisationUserRelation.fromMap(Map map,
      {Map organisationDetailsMap}) {
    try {
      Organisation org;
      if (organisationDetailsMap != null && organisationDetailsMap.isNotEmpty) {
        org = Organisation.fromMap(organisationDetailsMap);
      }
      return OrganisationUserRelation(
        organisationRef: map[OrganisationUserRelationSchema.organisationRef],
        organisationUserRef:
            map[OrganisationUserRelationSchema.organisationUserRef],
        role: EnumHelpers.getRole(map[OrganisationUserRelationSchema.orgRole]),
        status: EnumHelpers.getAcceptanceStatus(
            map[OrganisationUserRelationSchema.status]),
        organisation: org,
      );
    } catch (e, s) {
      print("organisation user catch____${e}____$s");
      return null;
    }
  }
}

class OrganisationUser {
  String name; // max value 156
  String email; // valid email
  var organisations = Map<String,
      OrganisationUserRelation>(); // id of map should be an Id of organisation in organisation collection
  Timestamp dateCreated; // FirestoreTimeStamp
  String organisationUserRefId;

  static OrganisationUser fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    try {
      print("inside map $map");
      //print("organisation ${map['organisations']}");
      var name = map['name'];
      print("name is $name");

      OrganisationUser organisationUser = OrganisationUser();
      organisationUser.name = map['name'];
      organisationUser.email = map['email'];
      organisationUser.organisationUserRefId =
          map['organisation_user_reference_id'];
      //organisationUser.organisations = map['organisations'];
      //var data = map['organisations'] as Map;

      // if (orgUserRelationMap != null && orgUserRelationMap.isNotEmpty) {
      //   orgUserRelationMap.forEach((element) {
      //     organisationUser.organisations[element.id] =
      //         OrganisationUserRelation.fromMap(element.data(),
      //             organisationDetailsMap: organisationDetailsMap);
      //   });

      // data.forEach((key, value) {
      //   var user = OrganisationSubscription.fromMap(value);
      //   var data = {key.toString(): user};
      //   organisationUser.organisations.addAll(data);
      // });
      //}
      organisationUser.dateCreated = map['date_created'];
      print("organisation is $organisationUser");
      return organisationUser;
    } catch (e, s) {
      print('create organisation user catch_____${e}____$s');
    }
  }

  Map toJson() => {
        "name": name,
        "email": email,
        "organisations": organisations,
        "date_created": dateCreated,
      };
}

// class OrganisationSubscription {
//   String companyName; //max length 75
//   AcceptanceStatus status; // check into fromMap and return the StatusEnums
//   Roles role; // check into fromMap and return the RolesEnum
//
//   static OrganisationSubscription fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
//     OrganisationSubscription userOrganisation = OrganisationSubscription();
//     userOrganisation.companyName = map['company_name'];
//     userOrganisation.role = EnumHelpers.getRole(map['role']);
//     userOrganisation.status = EnumHelpers.getAcceptanceStatus(map['status']);
//     return userOrganisation;
//   }
//
//   Map toJson() => {
//         "name": companyName,
//         "role": role,
//         "status": status,
//       };
// }

// Collection name: organisations
class Organisation {
  String companyName; //max length 75
  String brandColor; // Validate with # symbol with six digit

  static Organisation fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    Organisation organisation = Organisation();
    organisation.companyName = map['company_name'];
    organisation.brandColor = map['brand_color'];

    return organisation;
  }

  Map toJson() => {
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
// document is  organisations/organisation_id/company_info/billing_contact
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
// document is  organisations/organisation_id/company_info/general_contact
// note, inherits fields e.g. email from contacts Serialiser
  String website; // Validate URL

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
  // organisations/organisation_id/company_info/main
  String companyName; //validate
  Timestamp incorporationDate; // Validate
  String registrationNumber; //min & max length 8
  List<SICCode> sicCodes;
  List<Director> directors;
  AddressBasic address;
  Timestamp lastUpdated;
  Timestamp lastFilingDate;
  String vatNumber;
  Timestamp vatRegistrationDate;

  Company(
      {this.companyName,
      this.incorporationDate,
      this.registrationNumber,
      this.sicCodes,
      this.directors,
      this.address,
      this.lastUpdated,
      this.lastFilingDate,
      this.vatNumber,
      this.vatRegistrationDate});

  factory Company.fromMap(Map map) {
    try {
      return Company(
        companyName: map['company_name'],
        incorporationDate: map['incorporation_date'],
        registrationNumber: map['registration_number'],
        sicCodes: map.containsKey("sic_codes") && map["sic_codes"] != null
            ? List<SICCode>.from(
                map["sic_codes"].map((x) => SICCode.fromMap(x)))
            : [],
        directors: map.containsKey("directors") && map["directors"] != null
            ? List<Director>.from(
                map["directors"].map((x) => Director.fromMap(x)))
            : [],
        address: map.containsKey("address") && map["address"] != null
            ? AddressBasic.fromMap(map['address'])
            : null,
        lastUpdated: map['last_updated'],
        lastFilingDate: map['last_filing_date'],
        vatNumber: map['vat_number'],
        vatRegistrationDate: map['vat_registration_date'],
      );
    } catch (e, s) {
      print('company catch error $e,$s');
      return null;
    }
  }
}

class CompanyContract {
  String signedBy;
  DateTime signedAt;

  CompanyContract({this.signedBy, this.signedAt});

  factory CompanyContract.formMap(Map map) {
    if (map != null) {
      try {
        return CompanyContract(
            signedBy: map["signed_by"],
            signedAt: map["signed_at"] != null && map["signed_at"] is Timestamp
                ? map["signed_at"].toDate()
                : null);
      } catch (e) {
        print("company contract catch______$e");
        return null;
      }
    }
    return null;
  }
}

class UpdateUser {
  String name;
}

// this model is being used in both worker app and fielder model
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

// this model is being used in both worker app and fielder model
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
    this.groupCount,
  });

  String id;
  String name;
  String email;
  DateTime dateCreated;
  AcceptanceStatus status;
  String role;
  String manager;
  num groupCount;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
      id: json["id"],
      name: json["name"] == null ? null : json["name"],
      email: json["email"] == null ? null : json["email"],
      dateCreated: json["date_created"] == null
          ? null
          : DateTime.parse(json["date_created"]),
      status: json["status"] == null
          ? null
          : EnumHelpers.getAcceptanceStatus(json['status']),
      role: json["role"] == null ? null : json["role"],
      manager: json["manager"] == null ? null : json["manager"],
      groupCount: json['group_count']);

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "date_created":
            dateCreated == null ? null : dateCreated.toIso8601String(),
        "status": status == null ? null : status,
        "role": role == null ? null : role,
        "manager": manager == null ? null : manager,
        "group_count": groupCount,
      };

  static Future<UserDetail> getUserDetails(DocumentReference ref,
      {String collection = "shift_patterns"}) async {
    if (ref != null) {
      DocumentSnapshot ds = await FirebaseFirestore.instance
          .collection(collection)
          .doc(ref.id)
          .get();
      if (ds.exists && ds.data() != null) {
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

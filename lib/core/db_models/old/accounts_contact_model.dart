import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/old/schema/organisation_schema.dart';

class AccountsContactModel {
  String email;
  String name;
  String preferredNumber;
  String secondaryNumber;


  AccountsContactModel({
    this.secondaryNumber,
    this.email,
    this.preferredNumber,
    this.name,
  });

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> tempMap = Map();
    if (secondaryNumber != null) {
      if (secondaryNumber.isNotEmpty) {
        tempMap[OrganisationSchema.secondaryNumber] = secondaryNumber;
      }
    }

    if (email != null) {
      if (email.isNotEmpty) {
        tempMap[OrganisationSchema.email] = email;
      }
    }

    if (preferredNumber != null) {
      if (preferredNumber.isNotEmpty) {
        tempMap[OrganisationSchema.preferredNumber] = preferredNumber;
      }
    }

    if (name != null) {
      if (name.isNotEmpty) {
        tempMap[OrganisationSchema.name] = name;
      }
    }

    return tempMap;
  }

  factory AccountsContactModel.fromMap({
    @required Map<String, dynamic> map,
  }) {
    if (map.isNotEmpty) {
      final String _email = map[OrganisationSchema.email] ?? '';
      final String _name = map[OrganisationSchema.name] ?? '';
      final String _preferredNumber = map[OrganisationSchema.preferredNumber] ?? '';
      final String _secondaryNumber = map[OrganisationSchema.secondaryNumber] ?? '';
      return AccountsContactModel(
        secondaryNumber: _secondaryNumber,
        email: _email,
        preferredNumber: _preferredNumber,
        name: _name,
      );
    }
    return null;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/old/accounts_contact_model.dart';
import 'package:fielder_models/core/db_models/old/alternative_contact_model.dart';
import 'package:fielder_models/core/db_models/old/primary_contact_model.dart';
import 'package:fielder_models/core/db_models/old/schema/organisation_schema.dart';

class OrganisationModel {
  AccountsContactModel accountsContactModel;
  AlternativeContactModel alternativeContactModel;
  String docID;
  PrimaryContactModel primaryContactModel;
  String name;
  String email;
  String logoUrl;
  String brandBanner;
  String primaryColor;

  OrganisationModel(
      {this.accountsContactModel,
      this.alternativeContactModel,
      this.docID,
      this.primaryContactModel,
      this.name,
      this.email,
      this.brandBanner,
      this.logoUrl,
      this.primaryColor});
  factory OrganisationModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
    String namee,
  }) {
    if (map.isNotEmpty) {
      try {
        final String _name = map[OrganisationSchema.companyName] ?? '';
        final String _email = map[OrganisationSchema.email] ?? '';
        final String _logoUrl = map[OrganisationSchema.logo_url] ?? '';
        final String _primaryColor = map[OrganisationSchema.primary_color] ?? '';
        final String _brandBanner =map[OrganisationSchema.brand_banner] ?? '';

        AccountsContactModel _accountsContactModel;
        final Map<String, dynamic> _accountsContactRef =
            map[OrganisationSchema.accountsContact];
        if (_accountsContactRef != null) {
          _accountsContactModel = AccountsContactModel.fromMap(
            map: map[OrganisationSchema.accountsContact] ?? {},
          );
        }

        AlternativeContactModel _alternativeContactModel;
        final Map<String, dynamic> _alternativeContact =
            map[OrganisationSchema.alternativeContact];
        if (_alternativeContact != null) {
          _alternativeContactModel = AlternativeContactModel.fromMap(
            map: map[OrganisationSchema.alternativeContact] ?? {},
          );
        }

        PrimaryContactModel _primaryContactModel;
        final Map<String, dynamic> _primaryContactRef =
            map[OrganisationSchema.primaryContact];
        if (_primaryContactRef != null) {
          _primaryContactModel = PrimaryContactModel.fromMap(
            map: map[OrganisationSchema.primaryContact] ?? {},
          );
        }

        return OrganisationModel(
            accountsContactModel: _accountsContactModel,
            alternativeContactModel: _alternativeContactModel,
            docID: docID,
            name: _name != null
                ? _name
                : namee != null
                    ? namee
                    : "",
            email: _email,
            logoUrl: _logoUrl,
            primaryColor: _primaryColor,
            brandBanner: _brandBanner,
            primaryContactModel: _primaryContactModel);
      } catch (e) {
        print('OrganisationModel.fromMap error: $e');
      }
    } else {
      print("MAP IS EMPTY");
    }
    return null;
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> _map = {};

    try {
      _map = {
        OrganisationSchema.primaryContact: primaryContactModel.toJSON() ?? {},
        OrganisationSchema.alternativeContact:
            alternativeContactModel.toJSON() ?? {},
        OrganisationSchema.accountsContact: accountsContactModel.toJSON() ?? {},
      };
    } catch (error) {
      print('OrganisationModel toJSON error: $error');
    }

    return _map;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/old/accounts_contact_model.dart';
import 'package:fielder_models/core/db_models/old/alternative_contact_model.dart';
import 'package:fielder_models/core/db_models/old/primary_contact_model.dart';
import 'package:fielder_models/core/db_models/old/schema/employer_schema.dart';

class EmployerModel {
  AccountsContactModel accountsContactModel;
  AlternativeContactModel alternativeContactModel;
  String docID;
  PrimaryContactModel primaryContactModel;
  String name;
  String email;
  String logoUrl;
  String brandBanner;
  String primaryColor;

  EmployerModel(
      {this.accountsContactModel,
      this.alternativeContactModel,
      this.docID,
      this.primaryContactModel,
      this.name,
      this.email,
      this.brandBanner,
      this.logoUrl,
      this.primaryColor});
  factory EmployerModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
    String namee,
  }) {
    if (map.isNotEmpty) {
      try {
        final String _name = map[EmployerSchema.name] ?? '';
        final String _email = map[EmployerSchema.email] ?? '';
        final String _logoUrl = map[EmployerSchema.logo_url] ?? '';
        final String _primaryColor = map[EmployerSchema.primary_color] ?? '';
        final String _brandBanner =map[EmployerSchema.brand_banner] ?? '';

        AccountsContactModel _accountsContactModel;
        final Map<String, dynamic> _accountsContactRef =
            map[EmployerSchema.accountsContact];
        if (_accountsContactRef != null) {
          _accountsContactModel = AccountsContactModel.fromMap(
            map: map[EmployerSchema.accountsContact] ?? {},
          );
        }

        AlternativeContactModel _alternativeContactModel;
        final Map<String, dynamic> _alternativeContact =
            map[EmployerSchema.alternativeContact];
        if (_alternativeContact != null) {
          _alternativeContactModel = AlternativeContactModel.fromMap(
            map: map[EmployerSchema.alternativeContact] ?? {},
          );
        }

        PrimaryContactModel _primaryContactModel;
        final Map<String, dynamic> _primaryContactRef =
            map[EmployerSchema.primaryContact];
        if (_primaryContactRef != null) {
          _primaryContactModel = PrimaryContactModel.fromMap(
            map: map[EmployerSchema.primaryContact] ?? {},
          );
        }

        return EmployerModel(
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
        print('EmployerModel.fromMap error: $e');
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
        EmployerSchema.primaryContact: primaryContactModel.toJSON() ?? {},
        EmployerSchema.alternativeContact:
            alternativeContactModel.toJSON() ?? {},
        EmployerSchema.accountsContact: accountsContactModel.toJSON() ?? {},
      };
    } catch (error) {
      print('EmployerModel toJSON error: $error');
    }

    return _map;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/old/schema/job_template_schema.dart';

class AddressData {
  String _addressText;
  String _addressID;
  double _lat;
  double _lng;
  bool _isGoogle;

  String get addressText => _addressText;

  setAddressText(String value) {
    _addressText = value;
  }

  String get addressID => _addressID;

  setAddressID(String value) {
    _addressID = value;
  }

  double get lat => _lat;

  setLat(double value) {
    _lat = value;
  }

  double get lng => _lng;

  setLng(double value) {
    _lng = value;
  }

  bool get isGoogle => _isGoogle;

  setIsGoogle(bool value) {
    _isGoogle = value;
  }
}

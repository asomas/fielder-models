class AddressData {
  String _addressText;
  String _addressID;
  double _lat;
  double _lng;
  bool _isGoogle;
  String _addressShortName;

  String get addressShortName => _addressShortName;

  String get addressText => _addressText;

  setAddressShortName(String value) {
    _addressShortName = value;
  }

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

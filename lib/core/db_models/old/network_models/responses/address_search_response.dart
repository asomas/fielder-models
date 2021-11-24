class AddressSearchModel {
  AddressSearchModel({
    this.fielder,
    this.google,
  });

  Fielder fielder;
  List<Google> google;

  factory AddressSearchModel.fromJson(Map<String, dynamic> json) =>
      AddressSearchModel(
        fielder: Fielder.fromJson(json["fielder"]),
        google: List<Google>.from(
          json["google"].map(
            (x) => Google.fromJson(x),
          ),
        ),
      );
}

class Fielder {
  final List<Hit> hits;
  final int offset;
  final int limit;
  final int nbHits;
  final bool exhaustiveNbHits;
  final int processingTimeMs;
  final String query;

  Fielder({
    this.hits,
    this.offset,
    this.limit,
    this.nbHits,
    this.exhaustiveNbHits,
    this.processingTimeMs,
    this.query,
  });

  factory Fielder.fromJson(Map<String, dynamic> json) {
    //hits
    final List<dynamic> _hits = json['hits'] ?? [];
    List<Hit> _allHitsArray = [];
    _hits.forEach((element) {
      final Hit _address = Hit.fromJson(element);
      if (_address != null) {
        _allHitsArray.add(_address);
      }
    });

    return Fielder(
      hits: _allHitsArray,
      offset: json['offset'] ?? 0,
      limit: json['limit'] ?? 0,
      nbHits: json['nbHits'] ?? 0,
      exhaustiveNbHits: json['exhaustiveNbHits'] ?? false,
      processingTimeMs: json['processingTimeMs'] ?? 0,
      query: json['query'] ?? '',
    );
  }
}

class Hit {
  String locationId;
  String city;
  String country;
  String postalCode;
  String formattedAddress;
  String shortName;
  String name;
  String fullAddress;
  final double lat;
  final double lng;

  Hit({
    this.locationId,
    this.city,
    this.country,
    this.postalCode,
    this.formattedAddress,
    this.shortName,
    this.name,
    this.fullAddress,
    this.lat,
    this.lng,
  });

  factory Hit.fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      String _locationId = json["location_id"] ?? '';
      String _city = json["city"] ?? '';
      String _formattedAddress = json["formatted_address"] ?? '';
      String _shortName = json["short_name"] ?? '';
      String _name = json["name"] ?? '';
      String _country = json["country"] ?? '';
      String _postalCode = json["postal_code"] ?? '';
      double _lat = json["lat"];
      double _lng = json["lng"];
      String _fullAddress = "";
      if (_shortName.isNotEmpty) {
        _fullAddress += "$_shortName, ";
      }
      if (_name.isNotEmpty) {
        _fullAddress += "$_name, ";
      }
      if (_formattedAddress.isNotEmpty) {
        _fullAddress += "$_formattedAddress, ";
      }
      if (_locationId != null && _lat != null && _lng != null) {
        return Hit(
          locationId: _locationId,
          city: _city,
          country: _country,
          postalCode: _postalCode,
          formattedAddress: _formattedAddress,
          name: _name,
          shortName: _shortName,
          fullAddress: _fullAddress,
          lat: _lat,
          lng: _lng,
        );
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
        "location_id": locationId,
        "city": city,
        "country": country,
        "postal_code": postalCode,
        "lat": lat,
        "lng": lng,
      };
}

class Google {
  String address;
  double lat;
  double lng;
  String placeId;
  String name;

  Google({this.address, this.lat, this.lng, this.placeId, this.name});

  factory Google.fromJson(Map<String, dynamic> json) {
    try {
      if (json != null && json.isNotEmpty) {
        return Google(
          address: json["formatted_address"],
          lat: json["lat"].toDouble(),
          lng: json["lng"].toDouble(),
          placeId: json["place_id"],
          name: json["name"],
        );
      }
      return null;
    } catch (e, s) {
      print('google map error______${e}_____$s');
      return null;
    }
  }

  Map<String, dynamic> toJson() => {
        "formatted_address": address,
        "lat": lat,
        "lng": lng,
        "place_id": placeId,
        "name": name,
      };
}

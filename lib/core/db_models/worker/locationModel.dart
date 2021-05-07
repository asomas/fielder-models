import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/worker/schema/locationSchema.dart';

class LocationModelDetail {
  String name;
  String formattedAddress;
  GeoPoint coordinates;
  Address address;
  DocumentReference organisationRef;

  LocationModelDetail(
      {this.name,
      this.coordinates,
      this.formattedAddress,
      this.address,
      this.organisationRef});

  factory LocationModelDetail.fromJson(Map<String, dynamic> json) {
    var _coordinates;
    if (_coordinates != null && _coordinates is GeoPoint) {
      _coordinates = json[LocationSchema.coords];
    } else if (_coordinates != null) {
      double lat = json[LocationSchema.coords][LocationSchema.lat];
      double lng = json[LocationSchema.coords][LocationSchema.lng];
      GeoPoint geoPoint = GeoPoint(lat, lng);
      _coordinates = geoPoint;
    }
    try {
      return LocationModelDetail(
          name: json[LocationSchema.name] != null
              ? json[LocationSchema.name]
              : "",
          formattedAddress: json[LocationSchema.formattedAddress] != null
              ? json[LocationSchema.formattedAddress]
              : "",
          coordinates: _coordinates,
          address: json[LocationSchema.address] != null
              ? Address.fromJson(json[LocationSchema.address])
              : null,
          organisationRef: json[LocationSchema.organisationRef]);
    } catch (e, stacktrace) {
      print("locationModel.dart_______Catch______${e}_____$stacktrace");
      return null;
    }
  }
}

class Address {
  String building;
  String street;
  String county;
  String city;
  String country;
  String postalCode;

  Address(
      {this.building,
      this.street,
      this.county,
      this.city,
      this.country,
      this.postalCode});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        building: json[LocationSchema.building] != null
            ? json[LocationSchema.building]
            : "",
        street: json[LocationSchema.street] != null
            ? json[LocationSchema.street]
            : "",
        county: json[LocationSchema.county] != null
            ? json[LocationSchema.county]
            : "",
        city:
            json[LocationSchema.city] != null ? json[LocationSchema.city] : "",
        country: json[LocationSchema.country] != null
            ? json[LocationSchema.country]
            : "",
        postalCode: json[LocationSchema.postalCode] != null
            ? json[LocationSchema.postalCode]
            : "",
      );
}

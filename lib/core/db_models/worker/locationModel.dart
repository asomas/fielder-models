import 'package:fielder_models/core/db_models/worker/schema/locationSchema.dart';

class LocationDetail {
  String name;
  String formattedAddress;
  Coordinates coordinates;
  Address address;

  LocationDetail(
      {this.name, this.coordinates, this.formattedAddress, this.address});

  factory LocationDetail.fromJson(Map<String, dynamic> json) => LocationDetail(
      name: json[LocationSchema.name] != null ? json[LocationSchema.name] : "",
      formattedAddress: json[LocationSchema.formattedAddress] != null
          ? json[LocationSchema.formattedAddress]
          : "",
      coordinates: json[LocationSchema.coords] != null
          ? json[LocationSchema.coords]
          : null,
      address: json[LocationSchema.address] != null
          ? json[LocationSchema.address]
          : null);
}

class Coordinates {
  String lat;
  String lng;

  Coordinates({this.lat, this.lng});

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        lat: json[LocationSchema.lat].toDouble(),
        lng: json[LocationSchema.lng].toDouble(),
      );
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
        city: json[LocationSchema.county] != null
            ? json[LocationSchema.city]
            : "",
        country: json[LocationSchema.country] != null
            ? json[LocationSchema.country]
            : "",
        postalCode: json[LocationSchema.postalCode] != null
            ? json[LocationSchema.postalCode]
            : "",
      );
}

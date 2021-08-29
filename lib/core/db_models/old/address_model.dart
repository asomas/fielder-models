import 'package:fielder_models/core/db_models/old/schema/default_location_data_schema.dart';
import 'package:flutter/cupertino.dart';

class AddressModel {
  String building;
  String street;
  String county;
  String country;
  String city;
  String postalCode;
  String flat;

  AddressModel(
      {this.country,
      this.city,
      this.building,
      this.county,
      this.postalCode,
      this.street,
      this.flat});

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> tempMap = Map();
    if (country != null) {
      if (country.isNotEmpty) {
        tempMap[DefaultLocationDataSchema.country] = country;
      }
    }

    if (city != null) {
      if (city.isNotEmpty) {
        tempMap[DefaultLocationDataSchema.city] = city;
      }
    }

    if (building != null) {
      if (building.isNotEmpty) {
        tempMap[DefaultLocationDataSchema.building] = building;
      }
    }

    if (county != null) {
      if (county.isNotEmpty) {
        tempMap[DefaultLocationDataSchema.county] = county;
      }
    }

    if (postalCode != null) {
      if (postalCode.isNotEmpty) {
        tempMap[DefaultLocationDataSchema.postalCode] = postalCode;
      }
    }

    if (street != null) {
      if (street.isNotEmpty) {
        tempMap[DefaultLocationDataSchema.street] = street;
      }
    }

    if (flat != null) {
      if (flat.isNotEmpty) {
        tempMap[DefaultLocationDataSchema.flat] = flat;
      }
    }

    return tempMap;
  }

  factory AddressModel.fromMap({
    @required Map<String, dynamic> map,
  }) {
    if (map.isNotEmpty) {
      try {
        final String _building = map[DefaultLocationDataSchema.building] ?? '';
        final String _street = map[DefaultLocationDataSchema.street] ?? '';
        final String _county = map[DefaultLocationDataSchema.county] ?? '';
        final String _country = map[DefaultLocationDataSchema.country] ?? '';
        final String _city = map[DefaultLocationDataSchema.city] ?? '';
        final String _flat = map[DefaultLocationDataSchema.flat] ?? '';
        final String _postalCode =
            map[DefaultLocationDataSchema.postalCode] ?? '';

        return AddressModel(
            building: _building,
            street: _street,
            county: _county,
            country: _country,
            city: _city,
            flat: _flat,
            postalCode: _postalCode);
      } catch (e) {
        print('AddressModel fromMap error: $e');
      }
    }
    return null;
  }
}

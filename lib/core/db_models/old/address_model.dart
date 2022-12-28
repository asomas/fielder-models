import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/schema/default_location_data_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/hiring_request_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/invite_staff_schema.dart';
import 'package:fielder_models/core/db_models/worker/locationModel.dart';
import 'package:flutter/cupertino.dart';

class AddressModel {
  String building;
  String street;
  String county;
  String country;
  String city;
  String postalCode;
  String flat;
  String fullAddress;
  GeoPoint coordinates;

  AddressModel(
      {this.country,
      this.city,
      this.building,
      this.county,
      this.postalCode,
      this.street,
      this.flat,
      this.coordinates,
      this.fullAddress});

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> tempMap = Map();
    tempMap[DefaultLocationDataSchema.country] = country ?? '';
    tempMap[DefaultLocationDataSchema.city] = city ?? '';
    tempMap[DefaultLocationDataSchema.building] = building ?? '';
    tempMap[DefaultLocationDataSchema.county] = county ?? '';
    tempMap[DefaultLocationDataSchema.street] = street ?? '';
    tempMap[DefaultLocationDataSchema.postalCode] = postalCode ?? '';
    tempMap[DefaultLocationDataSchema.flat] = flat ?? '';
    return tempMap;
  }

  Map<String, dynamic> toJsonLocation() {
    Map<String, dynamic> addressMap = Map();
    addressMap[DefaultLocationDataSchema.country] = country ?? '';
    addressMap[DefaultLocationDataSchema.city] = city ?? '';
    addressMap[DefaultLocationDataSchema.building] = building ?? '';
    addressMap[DefaultLocationDataSchema.county] = county ?? '';
    addressMap[DefaultLocationDataSchema.street] = street ?? '';
    addressMap[DefaultLocationDataSchema.postalCode] = postalCode ?? '';
    addressMap[DefaultLocationDataSchema.flat] = flat ?? '';
    Map<String, dynamic> coordsMap = Map();
    coordsMap[DefaultLocationDataSchema.lat] = coordinates?.latitude;
    coordsMap[DefaultLocationDataSchema.lng] = coordinates?.longitude;
    Map<String, dynamic> locationMap = Map();
    locationMap[DefaultLocationDataSchema.address] = addressMap;
    if (coordinates != null) locationMap[DefaultLocationDataSchema.coordinates] = coordsMap;
    return locationMap;
  }

  factory AddressModel.fromObject(LocationModelDetail location) {
    AddressModel model = AddressModel(
      coordinates: location?.coordinates,
      county: location?.address?.county,
      country: location?.address?.country,
      city: location?.address?.city,
      building: location?.address?.building,
      flat: location?.address?.flat,
      street: location?.address?.street,
      postalCode: location?.address?.postalCode,
    );
    model?.fullAddress = getFullAddress(model);
    return model;
  }

  static String getFullAddress(AddressModel model) {
    final List<String> fullAddressMap = [
      model?.building,
      model?.street,
      model?.county,
      model?.country,
      model?.city,
      model?.flat,
      model?.postalCode
    ];
    fullAddressMap.removeWhere((element) => element == null || element.isEmpty);
    final String _fullAddress = fullAddressMap.join(',');
    return _fullAddress;
  }

  factory AddressModel.fromMap({
    @required Map<String, dynamic> map,
    GeoPoint coords,
  }) {
    if (map.isNotEmpty) {
      try {
        final String _building = map[DefaultLocationDataSchema.building] ?? '';
        final String _street = map[DefaultLocationDataSchema.street] ?? '';
        final String _county = map[DefaultLocationDataSchema.county] ?? '';
        final String _country = map[DefaultLocationDataSchema.country] ?? '';
        final String _city = map[DefaultLocationDataSchema.city] ?? '';
        final String _flat = map[DefaultLocationDataSchema.flat] ?? '';
        final String _postalCode = map[DefaultLocationDataSchema.postalCode] ?? '';

        AddressModel model = AddressModel(
          building: _building,
          street: _street,
          county: _county,
          country: _country,
          city: _city,
          flat: _flat,
          postalCode: _postalCode,
          coordinates: coords,
        );
        model.fullAddress = getFullAddress(model);
        return model;
      } catch (e) {
        print('AddressModel fromMap error: $e');
      }
    }
    return null;
  }

  factory AddressModel.fromInvitationsMap({@required Map<String, dynamic> map}) {
    if (map.isNotEmpty && map.containsKey(InviteStaffSchema.address) && map[InviteStaffSchema.address] != null) {
      try {
        final String _building = map[InviteStaffSchema.address][DefaultLocationDataSchema.building] ?? '';
        final String _street = map[InviteStaffSchema.address][DefaultLocationDataSchema.street] ?? '';
        final String _county = map[InviteStaffSchema.address][DefaultLocationDataSchema.county] ?? '';
        final String _country = map[InviteStaffSchema.address][DefaultLocationDataSchema.country] ?? '';
        final String _city = map[InviteStaffSchema.address][DefaultLocationDataSchema.city] ?? '';
        final String _flat = map[InviteStaffSchema.address][DefaultLocationDataSchema.flat] ?? '';
        final String _postalCode = map[InviteStaffSchema.address][DefaultLocationDataSchema.postalCode] ?? '';
        final String _formattedAddress = map[DefaultLocationDataSchema.formatted_address] ?? '';
        final GeoPoint _coords = map[DefaultLocationDataSchema.coordinates];

        return AddressModel(
            building: _building,
            street: _street,
            county: _county,
            country: _country,
            city: _city,
            flat: _flat,
            postalCode: _postalCode,
            fullAddress: _formattedAddress,
            coordinates: _coords);
      } catch (e) {
        print('AddressModel fromMap error: $e');
      }
    }
    return null;
  }

  factory AddressModel.fromHiringRequestMap({@required Map<String, dynamic> map}) {
    if (map.isNotEmpty && map.containsKey(HiringRequestSchema.address) && map[HiringRequestSchema.address] != null) {
      try {
        final String _building = map[InviteStaffSchema.address][DefaultLocationDataSchema.building] ?? '';
        final String _street = map[InviteStaffSchema.address][DefaultLocationDataSchema.street] ?? '';
        final String _county = map[InviteStaffSchema.address][DefaultLocationDataSchema.county] ?? '';
        final String _country = map[InviteStaffSchema.address][DefaultLocationDataSchema.country] ?? '';
        final String _city = map[InviteStaffSchema.address][DefaultLocationDataSchema.city] ?? '';
        final String _flat = map[InviteStaffSchema.address][DefaultLocationDataSchema.flat] ?? '';
        final String _postalCode = map[InviteStaffSchema.address][DefaultLocationDataSchema.postalCode] ?? '';
        final String _formattedAddress = map[DefaultLocationDataSchema.formatted_address] ?? '';
        final GeoPoint _coords = map[DefaultLocationDataSchema.coordinates];

        return AddressModel(
            building: _building,
            street: _street,
            county: _county,
            country: _country,
            city: _city,
            flat: _flat,
            postalCode: _postalCode,
            fullAddress: _formattedAddress,
            coordinates: _coords);
      } catch (e) {
        print('AddressModel fromMap error: $e');
      }
    }
    return null;
  }
}

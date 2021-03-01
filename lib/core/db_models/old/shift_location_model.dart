import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/address_model.dart';
import 'package:fielder_models/core/db_models/old/coordinates_data_model.dart';
import 'package:fielder_models/core/db_models/schema/default_location_data_schema.dart';

class ShiftLocationDataModel {
  final GeoPoint coordinates;
  final String address;

  ShiftLocationDataModel({
    this.address,
    this.coordinates,
  });

  factory ShiftLocationDataModel.fromMap(Map<String,dynamic> map){
    if(map?.isNotEmpty == true &&
        map[DefaultLocationDataSchema.coordinates] != null){
      String _address = "";
      if(map[DefaultLocationDataSchema.name] != null){
        _address = map[DefaultLocationDataSchema.name];
      }
      if(map[DefaultLocationDataSchema.formatted_address] != null){
        _address = _address + map[DefaultLocationDataSchema.formatted_address];
      }
      return ShiftLocationDataModel(
          coordinates: map[DefaultLocationDataSchema.coordinates],
          address: _address
      );
    }
    return null;
  }
}

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fielder_models/core/db_models/old/schema/shift_data_schema.dart';

class GooglePlaceModel{

  String placeID;
  Map coord;

  GooglePlaceModel({this.placeID, this.coord});

  factory GooglePlaceModel.fromMap(Map<String,dynamic> map){
    if(map?.isNotEmpty == true){
      return GooglePlaceModel(
        placeID: map[ShiftDataSchema.placeId],
        coord: _getMapFromLatLng(map[ShiftDataSchema.coords]),
      );
    }
    return null;
  }

  Map<String,dynamic> toJson(){
    return {
      ShiftDataSchema.placeId : placeID,
      ShiftDataSchema.coords : coord,
    };
  }

  static _getMapFromLatLng(LatLng coords){
    return {
      "lat" : coords.latitude,
      "lng" : coords.longitude
    };
  }
}


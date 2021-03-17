import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/address_model.dart';
import 'package:fielder_models/core/db_models/old/schema/default_location_data_schema.dart';

class EmployerLocation{

  String docId;
  AddressModel address;
  bool archived;
  GeoPoint coords;
  DocumentReference employerRef;
  String formattedAddress;
  String iconUrl;
  String name;
  String shortName;
  bool isLive;

  EmployerLocation(
      {this.docId,
      this.address,
      this.archived = false,
      this.coords,
      this.employerRef,
      this.formattedAddress = "",
      this.iconUrl,
      this.name = "",
      this.shortName = "",
      this.isLive = false}
      );
  
  factory EmployerLocation.fromMap(Map map, String docID){
    try{
      return EmployerLocation(
        docId: docID,
        address: AddressModel.fromMap(map: map[DefaultLocationDataSchema.address]),
        archived: map[DefaultLocationDataSchema.archived],
        coords: map[DefaultLocationDataSchema.coordinates],
        employerRef: map[DefaultLocationDataSchema.employerRef],
        formattedAddress: map[DefaultLocationDataSchema.formatted_address],
        iconUrl: map[DefaultLocationDataSchema.iconUrl],
        name: map[DefaultLocationDataSchema.name],
        shortName: map[DefaultLocationDataSchema.shortName],
        isLive: map[DefaultLocationDataSchema.isLive]
      );
    }catch(e){
      print("EMPLOYER LOCATION CATCH________$e");
      return null;
    }
  }
}


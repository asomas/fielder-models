import 'package:fielder_models/core/db_models/old/checks_model.dart';
import 'package:fielder_models/core/db_models/old/skills_model.dart';

class StaffPersonalDetailModel{
  String fullName;
  String preferredName;
  AddressModel addressModel;
  String phoneNumber;
  String personalStatement;
  String email;
  List<SkillsModel> skillsModelList;
  List<CheckModel> checkModelList;

  StaffPersonalDetailModel(
      {this.fullName,
      this.preferredName,
      this.addressModel,
      this.phoneNumber,
      this.personalStatement,
      this.email,
      this.skillsModelList,
      this.checkModelList});
  
  factory StaffPersonalDetailModel.fromMap(Map<String, dynamic> map){
    if(map != null && map.isNotEmpty){
      try{
        return StaffPersonalDetailModel(
          fullName: map["full_name"] ?? "",
          preferredName: map["preferred_name"] ?? "",
          addressModel: AddressModel.fromMap(map["address"]),
          phoneNumber: map["phone_number"] ?? "",
          personalStatement: map["personal_statement"] ?? "",
          email: map["email"],
          skillsModelList: (map["skills"] as List)?.isNotEmpty == true
              ? (map["skills"] as List)
              .map((e) => SkillsModel.fromMap(
              map: e,
              docID: ""
          )).toList() : [],
          checkModelList: (map["checks"] as List)?.isNotEmpty == true
              ? (map["checks"] as List)
              .map((e) => CheckModel.fromMap(
              map: e,
              checkID: ""
          )).toList() : [],
        );
      }
      catch(e){
        print("staff_personal_detail_model.dart_____StaffPersonalDetailModel Catch $e");
        return null;
      }
    }
    return null;
  }
}

class AddressModel {
  String building;
  String street;
  String county;
  String city;
  String country;
  String postalCode;
  String fullAddress;

  AddressModel({
    this.building,
    this.street,
    this.county,
    this.city,
    this.country,
    this.postalCode,
    this.fullAddress
  });

  factory AddressModel.fromMap(Map<String,dynamic> map){
    if(map != null && map.isNotEmpty){
      try{
        List _orderedKeys = [
          map["building"] ,
          map["street"],
          map["county"],
          map["city"] ,
          map["country"],
          map["postal_code"]
        ];
        List _addressList = [];
        _orderedKeys.forEach((element) {
          if (map[element] != null && map[element].isNotEmpty) {
            _addressList.add(map[element]);
          }
        });
        String _fullAddress = _addressList?.join(", ");
        return AddressModel(
            building: map["building"] ?? "",
            street: map["street"] ?? "",
            county: map["county"] ?? "",
            city: map["city"] ?? "",
            country: map["country"] ?? "",
            postalCode: map["postal_code"] ?? "",
            fullAddress: _fullAddress ?? ""
        );
      }catch(e){
        print("staff_personal_detail_model.dart_____Address Model Catch $e");
        return null;
      }
    }
    return null;
  }
}
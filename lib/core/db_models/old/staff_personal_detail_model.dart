import 'package:fielder_models/core/db_models/old/checks_model.dart';
import 'package:fielder_models/core/db_models/old/schema/staff_personal_detail_schema.dart';
import 'package:fielder_models/core/db_models/old/skills_model.dart';
import 'package:fielder_models/core/db_models/worker/workHistory/workHistory.dart';

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
          fullName: map[StaffPersonalDetailSchema.fullName] ?? "",
          preferredName: map[StaffPersonalDetailSchema.preferredName] ?? "",
          addressModel: AddressModel.fromMap(map[StaffPersonalDetailSchema.address]),
          phoneNumber: map[StaffPersonalDetailSchema.phoneNumber] ?? "",
          personalStatement: map[StaffPersonalDetailSchema.personalStatement] ?? "",
          email: map[StaffPersonalDetailSchema.email],
          skillsModelList: map[StaffPersonalDetailSchema.skills] != null
              ? List<Skill>.from(
              map[StaffPersonalDetailSchema.skills].map((e) =>
                  SkillsModel.fromMap(
                      map: e,
                  )))
              : [],
          checkModelList: map[StaffPersonalDetailSchema.checks] != null
              ? List<CheckModel>.from(
              map[StaffPersonalDetailSchema.checks].map((e) =>
                  CheckModel.fromMap(
                    map: e,
                  )))
              : [],
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
          map[StaffPersonalDetailSchema.building] ,
          map[StaffPersonalDetailSchema.street],
          map[StaffPersonalDetailSchema.county],
          map[StaffPersonalDetailSchema.city] ,
          map[StaffPersonalDetailSchema.country],
          map[StaffPersonalDetailSchema.postalCode]
        ];
        List _addressList = [];
        _orderedKeys.forEach((element) {
          if (map[element] != null && map[element].isNotEmpty) {
            _addressList.add(map[element]);
          }
        });
        String _fullAddress = _addressList?.join(", ");
        return AddressModel(
            building: map[StaffPersonalDetailSchema.building] ?? "",
            street: map[StaffPersonalDetailSchema.street] ?? "",
            county: map[StaffPersonalDetailSchema.county] ?? "",
            city: map[StaffPersonalDetailSchema.city] ?? "",
            country: map[StaffPersonalDetailSchema.country] ?? "",
            postalCode: map[StaffPersonalDetailSchema.postalCode] ?? "",
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
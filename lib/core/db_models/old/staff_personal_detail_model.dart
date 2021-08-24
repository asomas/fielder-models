import 'package:fielder_models/core/db_models/old/checks_model.dart';
import 'package:fielder_models/core/db_models/old/schema/staff_personal_detail_schema.dart';
import 'package:fielder_models/core/db_models/old/skills_model.dart';

class StaffPersonalDetailModel {
  String fullName;
  String preferredName;
  AddressModel addressModel;
  String phoneNumber;
  String personalStatement;
  String email;
  String workerReferenceId;
  List<SkillsModel> skillsModelList;
  List<CheckModel> checkModelList;

  StaffPersonalDetailModel(
      {this.fullName,
      this.workerReferenceId,
      this.preferredName,
      this.addressModel,
      this.phoneNumber,
      this.personalStatement,
      this.email,
      this.skillsModelList,
      this.checkModelList});

  factory StaffPersonalDetailModel.fromMap(Map<String, dynamic> map) {
    if (map != null && map.isNotEmpty) {
      try {
        return StaffPersonalDetailModel(
          fullName: map[StaffPersonalDetailSchema.fullName] ?? "",
          workerReferenceId:
              map[StaffPersonalDetailSchema.workerReferenceId] ?? "",
          preferredName: map[StaffPersonalDetailSchema.preferredName] ?? "",
          phoneNumber: map[StaffPersonalDetailSchema.phoneNumber] ?? "",
          personalStatement:
              map[StaffPersonalDetailSchema.personalStatement] ?? "",
          email: map[StaffPersonalDetailSchema.email],
          addressModel:
              AddressModel.fromMap(map[StaffPersonalDetailSchema.address]),
          skillsModelList: map[StaffPersonalDetailSchema.skills] != null
              ? List<SkillsModel>.from(map[StaffPersonalDetailSchema.skills]
                  .map((e) => SkillsModel.fromString(e)))
              : [],
          checkModelList: map[StaffPersonalDetailSchema.checks] != null
              ? List<CheckModel>.from(map[StaffPersonalDetailSchema.checks]
                  .map((e) => CheckModel.fromString(e)))
              : [],
        );
      } catch (e) {
        print(
            "staff_personal_detail_model.dart_____StaffPersonalDetailModel Catch $e");
        return null;
      }
    }
    return null;
  }
}

class AddressModel {
  String building;
  String street;
  String flat;
  String county;
  String town;
  String postCode;
  String fullAddress;

  AddressModel(
      {this.building,
      this.street,
      this.flat,
      this.county,
      this.town,
      this.postCode,
      this.fullAddress});

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    if (map != null && map.isNotEmpty) {
      try {
        List _orderedKeys = [
          map[StaffPersonalDetailSchema.flat],
          map[StaffPersonalDetailSchema.building],
          map[StaffPersonalDetailSchema.street],
          map[StaffPersonalDetailSchema.county],
          map[StaffPersonalDetailSchema.town],
          map[StaffPersonalDetailSchema.postcode]
        ];
        List _addressList = [];
        _orderedKeys.forEach((element) {
          if (element != null && element.isNotEmpty) {
            _addressList.add(element);
          }
        });
        String _fullAddress = _addressList?.join(", ");
        return AddressModel(
            building: map[StaffPersonalDetailSchema.building] ?? "",
            street: map[StaffPersonalDetailSchema.street] ?? "",
            flat: map[StaffPersonalDetailSchema.flat] ?? "",
            county: map[StaffPersonalDetailSchema.county] ?? "",
            town: map[StaffPersonalDetailSchema.town] ?? "",
            postCode: map[StaffPersonalDetailSchema.postcode] ?? "",
            fullAddress: _fullAddress ?? "");
      } catch (e) {
        print("staff_personal_detail_model.dart_____Address Model Catch $e");
        return null;
      }
    }
    return null;
  }
}

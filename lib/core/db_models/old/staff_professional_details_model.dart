import 'package:fielder_models/core/db_models/old/checks_model.dart';
import 'package:fielder_models/core/db_models/old/qualification_model.dart';
import 'package:fielder_models/core/db_models/old/skills_model.dart';
import 'package:fielder_models/core/db_models/worker/education/education.dart';
import 'package:fielder_models/core/db_models/worker/workHistory/workHistory.dart';

class StaffProfessionalDetailModel{
  List<SkillsModel> skillsModelList;
  List<CheckModel> checkModelList;
  List<QualificationModel> qualificationModelList;
  List<WorkHistory> workHistoryList;
  List<Education> educationList;


  StaffProfessionalDetailModel({
    this.skillsModelList,
    this.checkModelList,
    this.qualificationModelList,
    this.workHistoryList,
    this.educationList
  });

  factory StaffProfessionalDetailModel.fromMap(Map<String, dynamic> map){
    if(map != null && map.isNotEmpty){
      try{
        return StaffProfessionalDetailModel(
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
          qualificationModelList: (map["qualifications"] as List)?.isNotEmpty == true
                ? (map["qualifications"] as List)
                .map((e) => QualificationModel.fromMap(
                map: e,
                docID: ""
          )).toList() : [],
          workHistoryList: (map["work_history"] as List)?.isNotEmpty == true
              ? (map["work_history"] as List)
              .map((e) => WorkHistory.fromJson(e)).toList() : [],
          educationList: (map["education"] as List)?.isNotEmpty == true
              ? (map["education"] as List)
              .map((e) => Education.fromJson(e)).toList() : [],
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


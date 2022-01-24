import 'package:fielder_models/core/db_models/old/checks_model.dart';
import 'package:fielder_models/core/db_models/old/qualification_model.dart';
import 'package:fielder_models/core/db_models/old/schema/staff_professional_detail_schema.dart';
import 'package:fielder_models/core/db_models/old/skills_model.dart';
import 'package:fielder_models/core/db_models/worker/education/education.dart';
import 'package:fielder_models/core/db_models/worker/workHistory/workHistory.dart';
import 'package:fielder_models/core/db_models/worker/workHistoryEducationCombine.dart';

class StaffProfessionalDetailModel {
  List<SkillsModel> skillsModelList;
  List<CheckModel> checkModelList;
  List<QualificationModel> qualificationModelList;
  List<WorkHistory> workHistoryList;
  List<Education> educationList;
  List<WorkHistoryEducationCombine> workerExperience;

  StaffProfessionalDetailModel({
    this.skillsModelList,
    this.checkModelList,
    this.qualificationModelList,
    this.workHistoryList,
    this.educationList,
    this.workerExperience,
  });

  factory StaffProfessionalDetailModel.fromMap(Map<String, dynamic> map) {
    if (map != null && map.isNotEmpty) {
      try {
        return StaffProfessionalDetailModel(
          skillsModelList:
              (map[StaffProfessionalDetailSchema.skills] as List)?.isNotEmpty ==
                      true
                  ? (map[StaffProfessionalDetailSchema.skills] as List)
                      .map((e) => SkillsModel.fromString(e))
                      .toList()
                  : [],
          checkModelList:
              (map[StaffProfessionalDetailSchema.checks] as List)?.isNotEmpty ==
                      true
                  ? (map[StaffProfessionalDetailSchema.checks] as List)
                      .map((e) => CheckModel.fromString(e))
                      .toList()
                  : [],
          qualificationModelList:
              (map[StaffProfessionalDetailSchema.qualifications] as List)
                          ?.isNotEmpty ==
                      true
                  ? (map[StaffProfessionalDetailSchema.qualifications] as List)
                      .map((e) => QualificationModel.fromString(e))
                      .toList()
                  : [],
          workHistoryList:
              (map[StaffProfessionalDetailSchema.workHistories] as List)
                          ?.isNotEmpty ==
                      true
                  ? (map[StaffProfessionalDetailSchema.workHistories] as List)
                      .map((e) => WorkHistory.fromJson(e))
                      .toList()
                  : [],
          educationList: (map[StaffProfessionalDetailSchema.educations] as List)
                      ?.isNotEmpty ==
                  true
              ? (map[StaffProfessionalDetailSchema.educations] as List)
                  .map((e) => Education.fromJson(e))
                  .toList()
              : [],
          workerExperience:
              (map[StaffProfessionalDetailSchema.workHistories] as List)
                          ?.isNotEmpty ==
                      true
                  ? (map[StaffProfessionalDetailSchema.workHistories] as List)
                      .map((e) => WorkHistoryEducationCombine.fromJson(e))
                      .toList()
                  : [],
        );
      } catch (e, stacktrace) {
        print(
            "staff_personal_detail_model.dart_____StaffPersonalDetailModel Catch ${e}___$stacktrace");
        return null;
      }
    }
    return null;
  }
}

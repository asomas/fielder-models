import 'package:fielder_models/core/db_models/old/checks_model.dart';
import 'package:fielder_models/core/db_models/old/qualification_model.dart';
import 'package:fielder_models/core/db_models/old/schema/staff_professional_detail_schema.dart';
import 'package:fielder_models/core/db_models/old/skills_model.dart';
import 'package:fielder_models/core/db_models/worker/schema/workerHistorySchema.dart';
import 'package:fielder_models/core/db_models/worker/workHistoryEducationCombine.dart';

class StaffProfessionalDetailModel {
  List<SkillsModel> skillsModelList;
  List<CheckModel> checkModelList;
  List<QualificationModel> qualificationModelList;
  List<WorkHistoryEducationCombine> workerExperience;

  StaffProfessionalDetailModel({
    this.skillsModelList,
    this.checkModelList,
    this.qualificationModelList,
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
          workerExperience:
              (map[StaffProfessionalDetailSchema.workHistories] as List)
                          ?.isNotEmpty ==
                      true
                  ? (map[StaffProfessionalDetailSchema.workHistories] as List)
                      .map((e) => WorkHistoryEducationCombine.fromJson(e,
                          docId: e[WorkerHistorySchema.id]))
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

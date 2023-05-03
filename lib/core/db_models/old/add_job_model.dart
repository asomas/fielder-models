import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/helpers.dart';
import 'package:fielder_models/core/db_models/old/additional_info_model.dart';
import 'package:fielder_models/core/db_models/old/checks_model.dart';
import 'package:fielder_models/core/db_models/old/courses_and_level_model.dart';
import 'package:fielder_models/core/db_models/old/job_data_model.dart';
import 'package:fielder_models/core/db_models/old/job_template_model.dart';
import 'package:fielder_models/core/db_models/old/schema/job_summary_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/job_template_schema.dart';
import 'package:fielder_models/core/db_models/old/skills_model.dart';

class AddJobModel {
  String docId;
  String description;
  String richDescription;
  String title;
  String templateName;
  String jobReferenceId;
  JobTemplateModel selTemplate;
  List<AdditionalInfoModel> additionalReqsArray;
  List<SkillsModel> skillsArray;
  List<CheckModel> checksArray;
  List<dynamic> checks;
  bool isDBSRequired;
  bool isEnhancedDBSRequired;
  bool isArchived;
  List<CoursesAndLevelModel> courses;

  AddJobModel({
    this.docId,
    this.description = '',
    this.richDescription,
    this.templateName = '',
    this.title = '',
    this.jobReferenceId = '',
    this.selTemplate,
    this.additionalReqsArray,
    this.isDBSRequired = false,
    this.isEnhancedDBSRequired = false,
    this.skillsArray,
    this.checksArray,
    this.checks,
    this.courses,
    this.isArchived = false,
  });

  Map<String, dynamic> toJSON() {
    print('AddJobModel toJSON invoked');
    Map<String, dynamic> _map = {};
    try {
      _map = {
        JobTemplateSchema.name: templateName,
        JobTemplateSchema.description: description,
        JobTemplateSchema.descriptionRich: richDescription,
        JobTemplateSchema.jobTitle: title,
        JobTemplateSchema.skills: (skillsArray?.isNotEmpty == true)
            ? skillsArray.map((e) => e.toJSON()).toList() ?? []
            : [],
        JobTemplateSchema.additionalRequirements:
            (additionalReqsArray?.isNotEmpty == true)
                ? additionalReqsArray.map((e) => e.docID).toList() ?? []
                : [],
        JobTemplateSchema.checksIds: (checksArray?.isNotEmpty == true)
            ? checksArray.map((e) => e.checkID).toList() ?? []
            : [],
        JobSummarySchema.isArchived: isArchived ?? false,
        JobSummarySchema.courses: (courses?.isNotEmpty == true)
            ? courses.map((e) => e.toJsonForApi()).toList() ?? []
            : [],
        JobTemplateSchema.shiftPatternData: []
      };
      print("AddJobModel map -> $_map");
    } catch (e) {
      print('AddJobModel toJSON error: $e');
    }
    return _map;
  }

  factory AddJobModel.fromMap(Map data, {String docId}) {
    AddJobModel addJobModel;
    try {
      addJobModel = AddJobModel(
        docId: docId,
        title: data[JobTemplateSchema.jobTitle] ?? "",
        jobReferenceId: data[JobTemplateSchema.jobReferenceId],
        description: data[JobTemplateSchema.description] ?? "",
        richDescription: data[JobTemplateSchema.descriptionRich],
        templateName: data[JobTemplateSchema.name] ?? "",
        isArchived: data[JobSummarySchema.isArchived] ?? false,
        checksArray:
            (data[JobTemplateSchema.checks] as List)?.isNotEmpty == true
                ? (data[JobTemplateSchema.checks] as List)
                    .map((e) => CheckModel.fromMap(
                        map: e, checkID: e[JobTemplateSchema.checksRef]?.id))
                    .toList()
                : [],
        skillsArray: (data[JobTemplateSchema.skills] as List)?.isNotEmpty ==
                true
            ? (data[JobTemplateSchema.skills] as List).map(
                (e) {
                  String skillId = e[JobTemplateSchema.skillId];
                  if (skillId == null || skillId.isEmpty) {
                    if (e[JobTemplateSchema.skillRef] is DocumentReference) {
                      skillId =
                          (e[JobTemplateSchema.skillRef] as DocumentReference)
                              ?.id;
                    } else if (e[JobTemplateSchema.skillRef] is String) {
                      skillId = (Helpers.documentReferenceFromString(
                              e[JobTemplateSchema.skillRef]))
                          ?.id;
                    }
                  }
                  return SkillsModel.fromMap(
                    map: e,
                    docID: skillId,
                  );
                },
              ).toList()
            : [],
        // additionalReqsArray: (data[JobTemplateSchema.additionalRequirement]
        //                 as List)
        //             ?.isNotEmpty ==
        //         true
        //     ? (data[JobTemplateSchema.additionalRequirement] as List)
        //         .map((e) => AdditionalInfoModel.fromMap(
        //             map: e,
        //             docID: e[JobTemplateSchema.additionalRequirementRef]?.id))
        //         .toList()
        //     : [],
        courses: (data[JobSummarySchema.courses] as List)?.isNotEmpty == true
            ? (data[JobSummarySchema.courses] as List)
                .map((e) => CoursesAndLevelModel.fromMap(e))
                .toList()
            : [],
      );
    } catch (e, s) {
      print("job model catch____${e}____$s");
    }
    return addJobModel;
  }

  factory AddJobModel.fromJobDataModel(JobDataModel jobDataModel) {
    if (jobDataModel != null) {
      return AddJobModel(
        title: jobDataModel?.jobTitle,
        docId: jobDataModel?.docID,
        jobReferenceId: jobDataModel?.jobReferenceId,
        description: jobDataModel?.description,
        richDescription: jobDataModel?.richDescription,
        checks: jobDataModel?.checks,
        courses: jobDataModel?.courses,
        skillsArray: jobDataModel?.skills,
      );
    } else {
      return null;
    }
  }

  clear() {
    description = '';
    richDescription = null;
    templateName = '';
    title = '';
    selTemplate = null;
    additionalReqsArray = [];
    isDBSRequired = false;
    isEnhancedDBSRequired = false;
    skillsArray = [];
    checks = [];
    checksArray = [];
  }
}

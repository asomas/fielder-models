import 'package:fielder_models/core/db_models/old/additional_info_model.dart';
import 'package:fielder_models/core/db_models/old/checks_model.dart';
import 'package:fielder_models/core/db_models/old/courses_and_level_model.dart';
import 'package:fielder_models/core/db_models/old/job_template_model.dart';
import 'package:fielder_models/core/db_models/old/schema/job_summary_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/job_template_schema.dart';
import 'package:fielder_models/core/db_models/old/skills_model.dart';
import 'package:fielder_models/core/db_models/worker/occupation.dart';

class AddJobModel {
  String docId;
  String description;
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
  OccupationModel occupationModel;
  bool isArchived;
  List<CoursesAndLevelModel> courses;

  AddJobModel({
    this.docId,
    this.description = '',
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
    this.occupationModel,
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
        JobTemplateSchema.jobTitle: title,
        JobTemplateSchema.occupation: occupationModel.toJson(),
        JobTemplateSchema.skillsIds: (skillsArray?.isNotEmpty == true)
            ? skillsArray.map((e) => e.docID).toList() ?? []
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
      };
      print("AddJobModel map -> $_map");
    } catch (e) {
      print('AddJobModel toJSON error: $e');
    }
    return _map;
  }

  factory AddJobModel.fromMap(Map data, {String docId}) {
    AddJobModel addJobModel;

    print("checks are ${data[JobTemplateSchema.checks]}");

    if (data[JobTemplateSchema.jobReferenceId] != null) {
      addJobModel = AddJobModel(
        docId: docId,
        title: data[JobTemplateSchema.jobTitle] ?? "",
        jobReferenceId: data[JobTemplateSchema.jobReferenceId],
        description: data[JobTemplateSchema.description] ?? "",
        templateName: data[JobTemplateSchema.name] ?? "",
        isArchived: data[JobSummarySchema.isArchived] ?? false,
        occupationModel: data[JobTemplateSchema.occupation] != null
            ? OccupationModel.fromJson(data[JobTemplateSchema.occupation])
            : null,
        checksArray:
            (data[JobTemplateSchema.checks] as List)?.isNotEmpty == true
                ? (data[JobTemplateSchema.checks] as List)
                    .map((e) => CheckModel.fromMap(
                        map: e,
                        checkID: e[JobTemplateSchema.checksRef].toString()))
                    .toList()
                : [],
        skillsArray:
            (data[JobTemplateSchema.skills] as List)?.isNotEmpty == true
                ? (data[JobTemplateSchema.skills] as List)
                    .map((e) => SkillsModel.fromMap(
                        map: e,
                        docID: e[JobTemplateSchema.skillRef].toString()))
                    .toList()
                : [],
        additionalReqsArray:
            (data[JobTemplateSchema.additionalRequirement] as List)
                        ?.isNotEmpty ==
                    true
                ? (data[JobTemplateSchema.additionalRequirement] as List)
                    .map((e) => AdditionalInfoModel.fromMap(
                        map: e,
                        docID: e[JobTemplateSchema.additionalRequirementRef]
                            .toString()))
                    .toList()
                : [],
        courses: (data[JobSummarySchema.courses] as List)?.isNotEmpty == true
            ? (data[JobSummarySchema.courses] as List)
                .map((e) => CoursesAndLevelModel.fromMap(e))
                .toList()
            : [],
      );
    }
    return addJobModel;
  }

  clear() {
    description = '';
    templateName = '';
    title = '';
    selTemplate = null;
    additionalReqsArray = [];
    isDBSRequired = false;
    isEnhancedDBSRequired = false;
    skillsArray = [];
    checks = [];
    checksArray = [];
    occupationModel = null;
  }
}

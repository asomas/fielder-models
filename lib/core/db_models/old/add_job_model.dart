import 'dart:convert';
import 'package:fielder_models/core/db_models/old/additional_info_model.dart';
import 'package:fielder_models/core/db_models/old/checks_model.dart';
import 'package:fielder_models/core/db_models/old/job_template_model.dart';
import 'package:fielder_models/core/db_models/old/qualification_model.dart';
import 'package:fielder_models/core/db_models/old/schema/job_template_schema.dart';
import 'package:fielder_models/core/db_models/old/shift_data_model.dart';
import 'package:fielder_models/core/db_models/old/skills_model.dart';
import 'default_location_data_model.dart';

class AddJobModel {
  String description;
  String title;
  String templateName;
  String jobReferenceId;
  JobTemplateModel selTemplate;
  List<AdditionalInfoModel> additionalReqsArray;
  List<SkillsModel> skillsArray;
  List<CheckModel> checksArray;
  List<dynamic> checks;
  List<QualificationModel> requiredQualification;
  bool isDBSRequired;
  bool isEnhancedDBSRequired;
  String workLocationAddress;
  int rate;
  String payCalculation;
  int lateArrival;
  int earlyLeaver;
  int overTimeRate;
  DefaultLocationDataModel defaultLocationData;
  List<ShiftDataModel> shiftsArray;
  bool volunteer;
  bool payDetectionEnabled;

  AddJobModel(
      {this.description = '',
      this.templateName = '',
      this.title = '',
      this.jobReferenceId = '',
      this.selTemplate,
      this.additionalReqsArray,
      this.workLocationAddress,
      this.rate = 0,
      this.payCalculation = "Actual hours",
      this.lateArrival = 0,
      this.earlyLeaver = 0,
      this.overTimeRate,
      this.isDBSRequired = false,
      this.isEnhancedDBSRequired = false,
      this.requiredQualification,
      this.skillsArray,
      this.defaultLocationData,
      this.shiftsArray,
      this.volunteer = false,
      this.payDetectionEnabled = true,
      this.checksArray,
      this.checks});

  Map<String, dynamic> toJSON() {
    print('AddJobModel toJSON invoked');
    Map<String, dynamic> _map = {};
    try {
      print('job created invoked');

      List<dynamic> _shiftsMapArray = shiftsArray?.isNotEmpty == true
          ? shiftsArray.map((e) => e.toJSON()).toList()
          : [];

      _map = {
        JobTemplateSchema.name: templateName,
        JobTemplateSchema.description: description,
        JobTemplateSchema.jobTitle: title,
        JobTemplateSchema.volunteer: volunteer ?? false,
        JobTemplateSchema.rate: rate,
        JobTemplateSchema.payCalculation: payCalculation,
        JobTemplateSchema.lateArrival: lateArrival,
        JobTemplateSchema.earlyLeaver: earlyLeaver,
        JobTemplateSchema.overtimeRate: overTimeRate,
        JobTemplateSchema.skillsIds: (skillsArray?.isNotEmpty == true)
            ? skillsArray.map((e) => e.docID).toList() ?? []
            : [],
        JobTemplateSchema.qualificationsIds:
            (requiredQualification?.isNotEmpty == true)
                ? requiredQualification.map((e) => e.docID).toList() ?? []
                : [],
        JobTemplateSchema.additionalRequirements:
            (additionalReqsArray?.isNotEmpty == true)
                ? additionalReqsArray.map((e) => e.docID).toList() ?? []
                : [],
        // JobTemplateSchema.defaultLocationdata:
        //     defaultLocationData.toJSON() ?? {},
        JobTemplateSchema.shift_data: _shiftsMapArray,
        JobTemplateSchema.enablePayDetection: payDetectionEnabled,
        JobTemplateSchema.checksIds: (checksArray?.isNotEmpty == true)
            ? checksArray.map((e) => e.checkID).toList() ?? []
            : [],
      };

      print("AddJobModel map -> $_map");
    } catch (e) {
      print('AddJobModel toJSON error: $e');
    }
    return _map;
  }

  factory AddJobModel.fromMap(Map data) {
    AddJobModel addJobModel;

    print("checks are ${data[JobTemplateSchema.checks]}");

    if (data[JobTemplateSchema.jobReferenceId] != null) {
      addJobModel = AddJobModel(
        title: data[JobTemplateSchema.jobTitle] ?? "",
        jobReferenceId: data[JobTemplateSchema.jobReferenceId],
        description: data[JobTemplateSchema.description] ?? "",
        templateName: data[JobTemplateSchema.name] ?? "",
        volunteer: data[JobTemplateSchema.volunteer] ?? false,
        rate: data[JobTemplateSchema.rate] ?? 0,
        payCalculation: data[JobTemplateSchema.payCalculation] ?? "",
        lateArrival: data[JobTemplateSchema.lateArrival] ?? 0,
        earlyLeaver: data[JobTemplateSchema.earlyLeaver] ?? 0,
        overTimeRate: data[JobTemplateSchema.overtimeRate] ?? 0,
        payDetectionEnabled:
            data[JobTemplateSchema.enablePayDetection] ?? false,
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
        requiredQualification:
            (data[JobTemplateSchema.qualifications] as List)?.isNotEmpty == true
                ? (data[JobTemplateSchema.qualifications] as List)
                    .map((e) => QualificationModel.fromMap(
                        map: e,
                        docID:
                            e[JobTemplateSchema.qualificationRef].toString()))
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
    workLocationAddress = '';
    rate = 0;
    isDBSRequired = false;
    isEnhancedDBSRequired = false;
    requiredQualification = [];
    skillsArray = [];
    defaultLocationData = null;
    shiftsArray = [];
    checksArray = [];
  }

// sprint 8 work

//  factory AddJobModel.fromJSON(Map<String, dynamic> json) {
//    List<AdditionalInfoModel> additionalInfoModelList = [];
//    List<SkillsModel> skillsModelList = [];
//    List<QualificationModel> qualificationsModelList = [];
////    DefaultLocationDataModel defaultLocationDataModel = DefaultLocationDataModel(
////      address: AddressModel(
////          building: json['location']['address']
////      ),
////      coordinates: CoordinatesModel(),
////    );
//
//    final List<dynamic> skills = json[JobTemplateSchema.skills] ?? [];
//    skills.forEach((element) {
//      final DocumentReference ref = element['skill_ref'];
//      final Map<String, dynamic> map = element['skill_value'];
//      if (ref != null) {
//        final SkillsModel _skillsModel = SkillsModel.fromMap(
//            map: map, docID: ref.id);
//        if (_skillsModel != null) {
//          skillsModelList.add(_skillsModel);
//        }
//      }
//    });

//
//    final List<dynamic> qualifications = json[JobTemplateSchema.qualifications];
//    qualifications.forEach((element) {
//      final Map<String, dynamic> map = element['qualification_value'];
//      final DocumentReference ref = element['qualification_ref'];
//      if (ref != null) {
//        final QualificationModel _qualificationModel = QualificationModel
//            .fromMap(map: map, docID: ref.id);
//        if (_qualificationModel != null) {
//          qualificationsModelList.add(_qualificationModel);
//        }
//      }
//    });
//
//    final List<dynamic> additionalReq =
//        json[JobTemplateSchema.additionalRequirements] ?? [];
//    additionalReq.forEach((element) {
//      final Map<String, dynamic> map = element['additional_requirement_value'];
//      final DocumentReference ref = element['additional_requirement_ref'];
//      if (ref != null) {
//        AdditionalInfoModel _additionalInfoModel = AdditionalInfoModel.fromMap(
//          map: map,
//          docID: ref.id,
//        );
//        if (_additionalInfoModel != null) {
//          additionalInfoModelList.add(_additionalInfoModel);
//        }
//      }
//    });
//    return AddJobModel(
//        title: json[JobTemplateSchema.jobTitle],
//        description: json[JobTemplateSchema.description],
//        rate: json[JobTemplateSchema.rate],
////      isDBSRequired: json[JobTemplateSchema.]
//        volunteer: json[JobTemplateSchema.volunteer],
//        additionalReqsArray: additionalInfoModelList,
//        skillsArray: skillsModelList,
//        requiredQualification: qualificationsModelList,
//        defaultLocationData
//        :
//    );
//  }
}

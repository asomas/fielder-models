import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/additional_info_model.dart';
import 'package:fielder_models/core/db_models/old/checks_model.dart';
import 'package:fielder_models/core/db_models/old/default_location_data_model.dart';
import 'package:fielder_models/core/db_models/old/qualification_model.dart';
import 'package:fielder_models/core/db_models/old/schema/job_template_schema.dart';
import 'package:fielder_models/core/db_models/old/skills_model.dart';
import 'package:fielder_models/core/db_models/worker/occupation.dart';

class JobTemplateModel {
  final String jobTitle;
  final String description;
  final String jobTemplate;
  final List<AdditionalInfoModel> additionalRequirements;
  final List<SkillsModel> requiredSkill;
  final List<CheckModel> checks;
  final List<QualificationModel> requiredQualification;
  final String workLocationAddress;
  final int rate;
  final String name;
  final DocumentReference defaultLocation;
  final bool volunteer;
  final OccupationModel occupationModel;
  final DefaultLocationDataModel defaultLocationData;

  JobTemplateModel({
    this.jobTitle,
    this.description,
    this.jobTemplate,
    this.additionalRequirements,
    this.workLocationAddress,
    this.rate,
    this.requiredQualification,
    this.requiredSkill,
    this.volunteer = false,
    this.defaultLocation,
    this.name,
    this.checks,
    this.occupationModel,
    this.defaultLocationData,
  });

  factory JobTemplateModel.fromMap(Map<String, dynamic> map) {
    try {
      //Name
      final String name = map[JobTemplateSchema.name];

      //Additional Infos
      final List<dynamic> additionalRequirments =
          map['additional_requirements'] ?? [];
      List<AdditionalInfoModel> _infosArray = [];
      additionalRequirments.forEach((element) {
        final DocumentReference dr = element['additional_requirement_ref'];
        final Map<String, dynamic> map = {
          'value': element['additional_requirement_value'],
        };
        if (dr != null) {
          final AdditionalInfoModel _additionalInfo =
              AdditionalInfoModel.fromMap(
            map: map,
            docID: dr.id,
          );

          if (_additionalInfo != null) {
            _infosArray.add(_additionalInfo);
          }
        }
      });

      //Skills
      final List<dynamic> skills = map['skills'] ?? [];
      List<SkillsModel> _allSkillsArray = [];
      skills.forEach((element) {
        final DocumentReference dr = element['skill_ref'];
        final Map<String, dynamic> map = {
          'value': element['skill_value'],
        };
        if (dr != null) {
          final SkillsModel _skill = SkillsModel.fromMap(
            map: map,
            docID: dr.id,
          );

          if (_skill != null) {
            _allSkillsArray.add(_skill);
          }
        }
      });

      //Qualifications
      final List<dynamic> _qualifications = map['qualifications'] ?? [];
      OccupationModel _occupationModel;
      List<QualificationModel> _allQualificationsArray = [];
      _qualifications.forEach((element) {
        final DocumentReference dr = element['qualification_ref'];
        final Map<String, dynamic> map = {
          'value': element['qualification_value'],
        };
        if (dr != null) {
          final QualificationModel _qualification = QualificationModel.fromMap(
            map: map,
            docID: dr.id,
          );

          if (_qualification != null) {
            _allQualificationsArray.add(_qualification);
          }
        }
      });

      //Qualifications
      final List<dynamic> _checks = map['checks'] ?? [];
      List<CheckModel> _allChecksArray = [];
      _checks.forEach((element) {
        print("Element is $element");
        final DocumentReference dr = element['check_ref'];
        final Map<String, dynamic> map = {
          'value': element['check_value'],
        };
        if (dr != null) {
          final CheckModel _checks = CheckModel.fromMap(
            map: map,
            checkID: dr.id,
          );

          if (_checks != null) {
            _allChecksArray.add(_checks);
          }
        }
      });

      if (map.containsKey('occupation')) {
        _occupationModel = OccupationModel.fromJson(map['occupation']);
      }

      if (name != null) {
        return JobTemplateModel(
          name: name,
          additionalRequirements: _infosArray,
          description: map[JobTemplateSchema.description] ?? '',
          jobTitle: map[JobTemplateSchema.jobTitle] ?? '',
          rate: map[JobTemplateSchema.rate] ?? 0,
          requiredQualification: _allQualificationsArray,
          requiredSkill: _allSkillsArray,
          checks: _allChecksArray,
          volunteer: map[JobTemplateSchema.volunteer] ?? false,
          occupationModel: _occupationModel,
          workLocationAddress: map[JobTemplateSchema.location],
        );
      }
    } catch (e) {
      print('JobTemplateModel.fromMap error: $e');
    }

    return null;
  }

// Map<String, dynamic> toMap() {
//   final tempMap = Map();
//   tempMap[JobTemplateSchema.additionalRequirements] = additionalRequirments;
//   tempMap[JobTemplateSchema.defaultLocationRef] = defaultLocation;
//   tempMap[JobTemplateSchema.organisationData] = organisationData;
//   tempMap[JobTemplateSchema.organisationRef] = organisationRef;
//   tempMap[JobTemplateSchema.jobTitle] = jobTitle;
//   tempMap[JobTemplateSchema.location] = workLocationAddress;
//   tempMap[JobTemplateSchema.name] = name;
//   tempMap[JobTemplateSchema.qualifications] = requiredQualification;
//   tempMap[JobTemplateSchema.skills] = requiredSkill;
//   tempMap[JobTemplateSchema.rate] = rate;
//   tempMap[JobTemplateSchema.volunteer] = volunteer;
//
//   return tempMap;
// }

}

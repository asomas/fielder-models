import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/additional_info_model.dart';
import 'package:fielder_models/core/db_models/old/address_model.dart';
import 'package:fielder_models/core/db_models/old/default_location_data_model.dart';
import 'package:fielder_models/core/db_models/old/organisation_model.dart';
import 'package:fielder_models/core/db_models/old/pattern_data_model.dart';
import 'package:fielder_models/core/db_models/old/qualification_model.dart';
import 'package:fielder_models/core/db_models/old/schema/job_summary_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/job_template_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/shift_pattern_data_schema.dart';
import 'package:fielder_models/core/db_models/old/shift_activities_model.dart';
import 'package:fielder_models/core/db_models/old/skills_model.dart';
import 'package:fielder_models/core/db_models/old/workers_model.dart';
import 'package:flutter/cupertino.dart';

class JobDataModel {
  String docID;
  bool active;
  String jobTitle;
  DateTime startDate;
  DateTime endDate;
  double totalHours;
  int totalShiftsCount;
  List<String> issuesArray;
  List<WorkerModel> workersArray;
  List<JobLocationDataModel> locationsArray;

  JobDataModel({
    this.docID,
    this.active,
    this.jobTitle,
    this.startDate,
    this.endDate,
    this.totalHours,
    this.issuesArray,
    this.workersArray,
    this.locationsArray,
    this.totalShiftsCount = 0,
  }) : assert(docID != null);

  factory JobDataModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      try {
        final Timestamp _startTimeStamp = map[JobSummarySchema.startDate];
        DateTime _startDate;
        if (_startTimeStamp != null) {
          _startDate = DateTime.fromMillisecondsSinceEpoch(
            _startTimeStamp.millisecondsSinceEpoch,
          );
        }
        final Timestamp _endTimeStamp = map[JobSummarySchema.endDate];
        DateTime _endDate;
        if (_endTimeStamp != null) {
          _endDate = DateTime.fromMillisecondsSinceEpoch(
            _endTimeStamp.millisecondsSinceEpoch,
          );
        }
        final bool _active = map[JobSummarySchema.active] ?? false;
        final String _jobTitle = map[JobSummarySchema.jobTitle] ?? '';
        final double _totalHours = map[JobSummarySchema.totalHours] ?? 0;
        final Map<String, dynamic> workers =
            map[JobSummarySchema.workers] ?? {};
        List<WorkerModel> _allWorkerArray = [];
        workers.forEach((key, element) {
          final WorkerModel _worker = WorkerModel.fromMap(
            map: element,
            docID: key,
          );

          if (_worker != null) {
            _allWorkerArray.add(_worker);
          }
        });

        final Map<String, dynamic> locations =
            map[JobSummarySchema.locations] ?? {};
        List<JobLocationDataModel> _allLocationArray = [];
        locations.forEach((key, element) {
          final JobLocationDataModel _location = JobLocationDataModel.fromMap(
            map: element,
            docID: key,
          );

          if (_location != null) {
            _allLocationArray.add(_location);
          }
        });

        final List<dynamic> issues = map[JobSummarySchema.issues] ?? [];
        List<String> _allIssuesArray = [];
        issues.forEach((element) {
          if (element != null) {
            _allIssuesArray.add(element);
          }
        });

        return JobDataModel(
            docID: docID,
            startDate: _startDate,
            endDate: _endDate,
            active: _active,
            totalHours: _totalHours,
            jobTitle: _jobTitle,
            workersArray: _allWorkerArray,
            locationsArray: _allLocationArray,
            issuesArray: _allIssuesArray,
            totalShiftsCount: map[JobSummarySchema.totalShiftsCount]);
      } catch (e) {
        print('JobDataModel fromMap error: $e');
      }
    }
    return null;
  }
}

class JobLocationDataModel {
  String docID;
  final AddressModel address;

  JobLocationDataModel({
    this.docID,
    this.address,
  });

  factory JobLocationDataModel.fromMap({
    @required String docID,
    @required Map<String, dynamic> map,
  }) {
    if (map.isNotEmpty) {
      try {
        final Map<String, dynamic> addressMap =
            map[JobSummarySchema.address] ?? {};

        final AddressModel _address = AddressModel.fromMap(
          map: addressMap,
        );
        return JobLocationDataModel(docID: docID, address: _address);
      } catch (e) {
        print('JobLocation fromMap error: $e');
      }
    }
    return null;
  }
}

class ShiftPatternDataModel {
  String docID;
  OrganisationModel organisation;
  DateTime endDate;
  int endTimeInt;
  String jobTitle;
  String jobID;
  RecurrenceModel recurrence;
  String role;
  DateTime startDate;
  int startTimeInt;
  String workerId;
  String jobRefId;
  ShiftActivitiesModel shiftActivitiesModel;
  WorkerModel workerModel;
  bool isUnavailableForOrganisation;

  ShiftPatternDataModel(
      {this.docID,
      this.organisation,
      this.endDate,
      this.endTimeInt,
      this.jobTitle,
      this.jobID,
      this.jobRefId,
      this.recurrence,
      this.role,
      this.startDate,
      this.startTimeInt,
      this.workerId,
      this.shiftActivitiesModel,
      this.workerModel,
      this.isUnavailableForOrganisation = false})
      : assert(
          docID != null &&
              organisation != null &&
              endDate != null &&
              endTimeInt != null &&
              jobID != null &&
              recurrence != null &&
              startDate != null &&
              startTimeInt != null,
        );

  factory ShiftPatternDataModel.fromMap(
      {@required Map<String, dynamic> map,
      @required String docID,
      bool isUnavailable = false}) {
    if (map.isNotEmpty) {
      try {
        final Timestamp _startTimeStamp = map['start_date'];
        DateTime _startDate;
        if (_startTimeStamp != null) {
          _startDate = DateTime.fromMillisecondsSinceEpoch(
            _startTimeStamp.millisecondsSinceEpoch,
          );
        }
        final Timestamp _endTimeStamp = map['end_date'];
        DateTime _endDate;
        if (_endTimeStamp != null) {
          _endDate = DateTime.fromMillisecondsSinceEpoch(
            _endTimeStamp.millisecondsSinceEpoch,
          );
        }
        final int _startTimeInt = map['start_time'];
        final int _endTimeInt = map['end_time'];
        final RecurrenceModel _recurrence = RecurrenceModel.fromMap(
          map: map['recurrence'] ?? {},
        );
        final String _jobTitle = map['job_title'] ?? '';
        final String _jobRefId = map['job_reference_id'];
        final DocumentReference _jobRef = map['job_ref'] ?? '';
        final String _role = map['role'] ?? '';
        OrganisationModel _organisation;
        final DocumentReference _organisationRef = map['organisation_ref'];

        if (_organisationRef != null) {
          _organisation = OrganisationModel.fromMap(
            docID: _organisationRef.id,
            map: map['organisation_data'] ?? {},
          );
        }
        ShiftActivitiesModel _shiftActivitiesModel;
        final DocumentReference _workerRef = map['worker_ref'];
        final DocumentReference _shiftActivityRef = map['shift_activity_ref'];

        if (_workerRef != null && _shiftActivityRef != null) {
          _shiftActivitiesModel = ShiftActivitiesModel.fromMap(
              map: map['shift_activity_data'] ?? {},
              docID: _shiftActivityRef.id);
        }
        if (_jobRef != null) {
          return ShiftPatternDataModel(
              docID: docID,
              jobRefId: _jobRefId,
              startDate: _startDate,
              endDate: _endDate,
              startTimeInt: _startTimeInt,
              endTimeInt: _endTimeInt,
              recurrence: _recurrence,
              jobTitle: _jobTitle,
              jobID: _jobRef?.id,
              role: _role,
              isUnavailableForOrganisation: isUnavailable,
              organisation: _organisation,
              shiftActivitiesModel: _shiftActivitiesModel,
              workerId: _workerRef?.id,
              workerModel: map.containsKey(ShiftDataSchema.workerData)
                  ? WorkerModel.fromMap(
                      map: map[ShiftDataSchema.workerData],
                      docID: map[ShiftDataSchema.workerRef]?.id)
                  : null);
        }
      } catch (e) {
        print('ShiftPatternDataModel fromMap error: $e');
      }
    }
    return null;
  }
}

class JobSummaryDataModel {
  String docID;
  String organisationID;
  JobDataModel jobDataModel;
  String jobID;
  List<WorkerModel> workersArray;

  JobSummaryDataModel({
    this.docID,
    this.organisationID,
    this.jobDataModel,
    this.jobID,
    this.workersArray,
  }) : assert(
          docID != null && jobDataModel != null && jobID != null,
        );

  factory JobSummaryDataModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      try {
        String _organisationID = '';
        final DocumentReference _organisationRef =
            map[JobSummarySchema.organisationRef];
        if (_organisationRef != null) {
          _organisationID = _organisationRef.id;
          String _jobID = '';
          final DocumentReference _jobRef = map[JobSummarySchema.jobRef];
          if (_jobRef != null) {
            _jobID = _jobRef.id;

            final JobDataModel _jobDataModel = JobDataModel.fromMap(
                map: map[JobSummarySchema.jobData] ?? {}, docID: _jobID);
            final Map<String, dynamic> workers =
                map[JobSummarySchema.workers] ?? {};
            List<WorkerModel> _allWorkerArray = [];
            workers.forEach((key, element) {
              final WorkerModel _worker = WorkerModel.fromMap(
                map: element,
                docID: key,
              );

              if (_worker != null) {
                _allWorkerArray.add(_worker);
              }
            });

            if (_jobID.isNotEmpty) {
              return JobSummaryDataModel(
                docID: docID,
                organisationID: _organisationID,
                jobDataModel: _jobDataModel,
                jobID: _jobID,
                workersArray: _allWorkerArray,
              );
            }
          }
        }
      } catch (e) {
        print('JobSummaryDataModel fromMap error: $e');
      }
    }
    return null;
  }
}

class JobTemplateModel {
  final String jobTitle;
  final String description;
  final String jobTemplate;
  final List<AdditionalInfoModel> additionalRequirements;
  final List<SkillsModel> requiredSkill;
  final List<QualificationModel> requiredQualification;
  final String workLocationAddress;
  final int rate;
  final String name;
  final DocumentReference defaultLocation;
  final bool volunteer;
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
      List<SkillsModel> _allSkillsArray = map[JobTemplateSchema.skills] != null
          ? List<SkillsModel>.from(map[JobTemplateSchema.skills]
              .map((x) => SkillsModel.fromMap(map: x)))
          : [];

      //Qualifications
      final List<dynamic> _qualifications = map['qualifications'] ?? [];
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

      if (name != null) {
        return JobTemplateModel(
          name: name,
          additionalRequirements: _infosArray,
          description: map[JobTemplateSchema.description] ?? '',
          jobTitle: map[JobTemplateSchema.jobTitle] ?? '',
          rate: map[JobTemplateSchema.rate] ?? 0,
          requiredQualification: _allQualificationsArray,
          requiredSkill: _allSkillsArray,
          volunteer: map[JobTemplateSchema.volunteer] ?? false,
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

class JobSearchTemplate {
  final num limit;
  final List<OrganisationJobTemplate> organisationJobTemplate;
  final List<FielderJobTemplate> fielderJobTemplate;

  JobSearchTemplate(
      {this.limit, this.organisationJobTemplate, this.fielderJobTemplate});

  factory JobSearchTemplate.fromMap(Map<String, dynamic> map) {
    JobSearchTemplate temp;
    try {
      temp = JobSearchTemplate(
          limit: map["organisation_templates"] != null
              ? map["organisation_templates"]["limit"]
              : 10,
          organisationJobTemplate: map["organisation_templates"] != null
              ? _getOrganisationJobTemplate(
                  map["organisation_templates"]["hits"])
              : [],
          fielderJobTemplate: map["fielder_templates"] != null
              ? _getFielderJobTemplate(map["fielder_templates"]["hits"])
              : []);
      return temp;
    } catch (e) {
      print("template error: $e");
      return null;
    }
  }

  static List<OrganisationJobTemplate> _getOrganisationJobTemplate(List hits) {
    List<OrganisationJobTemplate> list = [];
    hits.forEach((element) {
      list = (hits)
          .map((model) => OrganisationJobTemplate.fromMap(model))
          .toList();
    });
    return list;
  }

  static List<FielderJobTemplate> _getFielderJobTemplate(List hits) {
    List<FielderJobTemplate> list = [];
    hits.forEach((element) {
      list = (hits).map((model) => FielderJobTemplate.fromMap(model)).toList();
    });
    return list;
  }
}

class OrganisationJobTemplate {
  final String organisationTemplateID;
  final String organisationTemplateName;
  final String organisationID;

  OrganisationJobTemplate({
    this.organisationTemplateID,
    this.organisationTemplateName,
    this.organisationID,
  });

  factory OrganisationJobTemplate.fromMap(Map<String, dynamic> map) {
    return OrganisationJobTemplate(
        organisationTemplateID: map["organisation_template_id"] ?? "",
        organisationTemplateName: map["name"] ?? "",
        organisationID: map["organisation_id"] ?? "");
  }
}

class FielderJobTemplate {
  final String fielderTemplateID;
  final String fielderTemplateName;

  FielderJobTemplate({
    this.fielderTemplateID,
    this.fielderTemplateName,
  });

  factory FielderJobTemplate.fromMap(Map<String, dynamic> map) {
    return FielderJobTemplate(
      fielderTemplateID: map["fielder_template_id"] ?? "",
      fielderTemplateName: map["name"] ?? "",
    );
  }
}

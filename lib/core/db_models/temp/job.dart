import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/additional_info_model.dart';
import 'package:fielder_models/core/db_models/address_model.dart';
import 'package:fielder_models/core/db_models/default_location_data_model.dart';
import 'package:fielder_models/core/db_models/employer_model.dart';
import 'package:fielder_models/core/db_models/qualification_model.dart';
import 'package:fielder_models/core/db_models/schema/job_template_schema.dart';
import 'package:fielder_models/core/db_models/schema/shift_data_schema.dart';
import 'package:fielder_models/core/db_models/shift_data_model.dart';
import 'package:fielder_models/core/db_models/skills_model.dart';
import 'package:fielder_models/core/db_models/worker_tracked_time_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/schema/job_summary_schema.dart';
import 'package:fielder_models/core/db_models/workers_model.dart';

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
        final Map<String, dynamic> workers = map[JobSummarySchema.workers] ?? {};
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

        final Map<String, dynamic> locations = map[JobSummarySchema.locations] ?? {};
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
        final Map<String, dynamic> addressMap = map[JobSummarySchema.address] ?? {};

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

class JobShiftDataModel {
  String docID;
  EmployerModel employer;
  DateTime endDate;
  int endTimeInt;
  String jobTitle;
  String jobID;
  RecurrenceModel recurrence;
  String role;
  DateTime startDate;
  int startTimeInt;
  String workerId;
  WorkerTrackedTimeModel workerLogModel;
  WorkerModel workerModel;

  JobShiftDataModel(
      {this.docID,
      this.employer,
      this.endDate,
      this.endTimeInt,
      this.jobTitle,
      this.jobID,
      this.recurrence,
      this.role,
      this.startDate,
      this.startTimeInt,
      this.workerId,
      this.workerLogModel,
      this.workerModel})
      : assert(
          docID != null &&
              employer != null &&
              endDate != null &&
              endTimeInt != null &&
              jobID != null &&
              recurrence != null &&
              startDate != null &&
              startTimeInt != null,
        );

  factory JobShiftDataModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
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
        final DocumentReference _jobRef = map['job_ref'] ?? '';
        final String _role = map['role'] ?? '';
        EmployerModel _employer;
        final DocumentReference _employerRef = map['employer_ref'];

        if (_employerRef != null) {
          _employer = EmployerModel.fromMap(
            docID: _employerRef.id,
            map: map['employer_data'] ?? {},
          );
        }
        WorkerTrackedTimeModel _workerLogModel;
        final DocumentReference _workerRef = map['worker_ref'];
        final DocumentReference _workerLogRef = map['worker_tracked_time_ref'];

        if (_workerRef != null && _workerLogRef != null) {
          _workerLogModel =
              WorkerTrackedTimeModel.fromMap(map: map['worker_tracked_time_data'] ?? {}, docID: _workerLogRef.id);
        }
        if (_jobRef != null) {
          return JobShiftDataModel(
              docID: docID,
              startDate: _startDate,
              endDate: _endDate,
              startTimeInt: _startTimeInt,
              endTimeInt: _endTimeInt,
              recurrence: _recurrence,
              jobTitle: _jobTitle,
              jobID: _jobRef?.id,
              role: _role,
              employer: _employer,
              workerLogModel: _workerLogModel,
              workerId: _workerRef?.id,
              workerModel: map.containsKey(ShiftDataSchema.workerData)
                  ? WorkerModel.fromMap(map: map[ShiftDataSchema.workerData], docID: map[ShiftDataSchema.workerRef]?.id)
                  : null);
        }
      } catch (e) {
        print('JobShiftDataModel fromMap error: $e');
      }
    }
    return null;
  }
}

class JobSummaryDataModel {
  String docID;
  String employerID;
  JobDataModel jobDataModel;
  String jobID;
  List<WorkerModel> workersArray;

  JobSummaryDataModel({
    this.docID,
    this.employerID,
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
        String _employerID = '';
        final DocumentReference _employerRef = map[JobSummarySchema.employerRef];
        if (_employerRef != null) {
          _employerID = _employerRef.id;
          String _jobID = '';
          final DocumentReference _jobRef = map[JobSummarySchema.jobRef];
          if (_jobRef != null) {
            _jobID = _jobRef.id;

            final JobDataModel _jobDataModel =
                JobDataModel.fromMap(map: map[JobSummarySchema.jobData] ?? {}, docID: _jobID);
            final Map<String, dynamic> workers = map[JobSummarySchema.workers] ?? {};
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
                employerID: _employerID,
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
      final List<dynamic> additionalRequirments = map['additional_requirements'] ?? [];
      List<AdditionalInfoModel> _infosArray = [];
      additionalRequirments.forEach((element) {
        final DocumentReference dr = element['additional_requirement_ref'];
        final Map<String, dynamic> map = {
          'value': element['additional_requirement_value'],
        };
        if (dr != null) {
          final AdditionalInfoModel _additionalInfo = AdditionalInfoModel.fromMap(
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
//   tempMap[JobTemplateSchema.employerData] = employerData;
//   tempMap[JobTemplateSchema.employerRef] = employerRef;
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
  final List<EmployerJobTemplate> employerJobTemplate;
  final List<FielderJobTemplate> fielderJobTemplate;

  JobSearchTemplate({this.limit, this.employerJobTemplate, this.fielderJobTemplate});

  factory JobSearchTemplate.fromMap(Map<String, dynamic> map) {
    JobSearchTemplate temp;
    try {
      temp = JobSearchTemplate(
          limit: map["employer_templates"] != null ? map["employer_templates"]["limit"] : 10,
          employerJobTemplate:
              map["employer_templates"] != null ? _getEmployerJobTemplate(map["employer_templates"]["hits"]) : [],
          fielderJobTemplate:
              map["fielder_templates"] != null ? _getFielderJobTemplate(map["fielder_templates"]["hits"]) : []);
      return temp;
    } catch (e) {
      print("template error: $e");
      return null;
    }
  }

  static List<EmployerJobTemplate> _getEmployerJobTemplate(List hits) {
    List<EmployerJobTemplate> list = [];
    hits.forEach((element) {
      list = (hits).map((model) => EmployerJobTemplate.fromMap(model)).toList();
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

class EmployerJobTemplate {
  final String employerTemplateID;
  final String employerTemplateName;
  final String employerID;

  EmployerJobTemplate({
    this.employerTemplateID,
    this.employerTemplateName,
    this.employerID,
  });

  factory EmployerJobTemplate.fromMap(Map<String, dynamic> map) {
    return EmployerJobTemplate(
        employerTemplateID: map["employer_template_id"] ?? "",
        employerTemplateName: map["name"] ?? "",
        employerID: map["employer_id"] ?? "");
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

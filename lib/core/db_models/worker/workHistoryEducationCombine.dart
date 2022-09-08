import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/skills_model.dart';
import 'package:fielder_models/core/db_models/worker/education/education.dart';
import 'package:fielder_models/core/db_models/worker/locationModel.dart';
import 'package:fielder_models/core/db_models/worker/occupation.dart';
import 'package:fielder_models/core/db_models/worker/schema/educationSchema.dart';
import 'package:fielder_models/core/db_models/worker/schema/workerHistorySchema.dart';
import 'package:fielder_models/core/db_models/worker/workHistory/workHistory.dart';

class WorkHistoryEducationCombine {
  String docId;
  ExperienceType workerType;
  Timestamp endDate;
  Timestamp startDate;
  LocationModelDetail location;
  String organisationName;
  String jobTitle;
  List<SkillsModel> skills;
  List<KnowledgeArea> knowledgeAreaList;
  List<SicCode> sicCode;
  OccupationModel occupation;
  EducationInstitution educationInstitution;
  Course course;
  bool expanded;
  VerificationStatus verificationStatus;
  String companyLogo;
  RefereeModel refereeModel;
  String summary;
  Level level;
  Grade grade;
  bool award;
  bool hasAcceptableReference;
  ApprovalData approvalData;

  WorkHistoryEducationCombine({
    this.docId,
    this.endDate,
    this.startDate,
    this.location,
    this.organisationName,
    this.skills,
    this.knowledgeAreaList,
    this.sicCode,
    this.occupation,
    this.educationInstitution,
    this.course,
    this.jobTitle,
    this.workerType,
    this.expanded,
    this.verificationStatus,
    this.companyLogo,
    this.refereeModel,
    this.summary,
    this.level,
    this.grade,
    this.award,
    this.hasAcceptableReference,
    this.approvalData,
  });

  factory WorkHistoryEducationCombine.fromJson(Map<String, dynamic> json,
      {String docId}) {
    if (json != null && json.isNotEmpty) {
      try {
        var _endDate, _startDate;
        _endDate = json[WorkerHistorySchema.endDate];
        _startDate = json[WorkerHistorySchema.startDate];
        if (_endDate != null && _endDate is String) {
          String split = _endDate.toString().split("T")[0];
          _endDate = Timestamp.fromDate(DateTime.parse(split));
        }
        if (_startDate != null && _startDate is String) {
          String split = _startDate.toString().split("T")[0];
          _startDate = Timestamp.fromDate(DateTime.parse(split));
        }
        return WorkHistoryEducationCombine(
          docId: docId,
          endDate: _endDate,
          startDate: _startDate,
          location: json[EducationSchema.locationData] != null
              ? LocationModelDetail.fromJson(json[EducationSchema.locationData])
              : null,
          organisationName: json[WorkerHistorySchema.organisationName] != null
              ? json[WorkerHistorySchema.organisationName]
              : "",
          jobTitle: json[WorkerHistorySchema.jobTitle] ?? "",
          expanded: json[WorkerHistorySchema.expanded] ?? false,
          skills: json[WorkerHistorySchema.skills] != null
              ? List<SkillsModel>.from(json[WorkerHistorySchema.skills]
                  .map((x) => SkillsModel.fromMap(map: x)))
              : [],
          knowledgeAreaList: json[EducationSchema.knowledgeAreas] != null
              ? List<KnowledgeArea>.from(json[EducationSchema.knowledgeAreas]
                  .map((x) => KnowledgeArea.fromJson(x)))
              : [],
          sicCode: json[WorkerHistorySchema.sicCode] != null
              ? List<SicCode>.from(json[WorkerHistorySchema.sicCode]
                  .map((x) => SicCode.fromJson(x)))
              : [],
          occupation: json[WorkerHistorySchema.occupation] != null
              ? OccupationModel.fromJson(json[WorkerHistorySchema.occupation])
              : null,
          educationInstitution: json[EducationSchema.institution] != null
              ? EducationInstitution.fromJson(json[EducationSchema.institution])
              : null,
          course: json[EducationSchema.course] != null
              ? Course.fromJson(json[EducationSchema.course])
              : null,
          workerType: WorkHistory.getWorkerType(json[WorkerHistorySchema.type]),
          verificationStatus: WorkHistory.verificationStatusFromString(
              json[WorkerHistorySchema.status]),
          refereeModel:
              RefereeModel.fromMap(json[WorkerHistorySchema.referencingData]),
          summary: json[WorkerHistorySchema.summary],
          level: json[EducationSchema.level] != null
              ? Level.fromJson(json[EducationSchema.level])
              : null,
          grade: json[EducationSchema.grade] != null
              ? Grade.fromJson(json[EducationSchema.grade])
              : null,
          award: json[EducationSchema.award] != null
              ? json[EducationSchema.award]
              : null,
          hasAcceptableReference:
              json[WorkerHistorySchema.hasAcceptableReference],
          approvalData:
              ApprovalData.fromMap(json[WorkerHistorySchema.approvalData]),
        );
      } catch (e, s) {
        print("worker experience model catch______${e}_____$s");
        return null;
      }
    } else {
      return null;
    }
  }
}

class ApprovalData {
  String userName;
  DateTime approvalDate;

  ApprovalData({this.userName, this.approvalDate});

  factory ApprovalData.fromMap(Map map) {
    if (map != null && map.isNotEmpty) {
      try {
        var _approvalDate;
        _approvalDate = map[WorkerHistorySchema.approvalDate];
        if (_approvalDate != null && _approvalDate is String) {
          String split = _approvalDate.toString().split("T")[0];
          _approvalDate = Timestamp.fromDate(DateTime.parse(split));
        }

        return ApprovalData(
          userName: map[WorkerHistorySchema.userName],
          approvalDate: _approvalDate?.toDate(),
        );
      } catch (e, s) {
        print("approval data from map catch____${e}______$s");
        return null;
      }
    } else {
      return null;
    }
  }
}

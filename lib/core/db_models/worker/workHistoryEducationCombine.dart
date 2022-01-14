import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/worker/education/education.dart';
import 'package:fielder_models/core/db_models/worker/locationModel.dart';
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
  List<Skill> skills;
  List<KnowledgeArea> knowledgeAreaList;
  List<SicCode> sicCode;
  Occupation occupation;
  EducationInstitution educationInstitution;
  Course course;
  bool expanded;
  VerificationStatus verificationStatus;
  String companyLogo;
  RefereeModel refereeModel;
  String summary;

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
  });

  factory WorkHistoryEducationCombine.fromJson(Map<String, dynamic> json,
          {String docId}) {
    try{
      var _startDate = json[EducationSchema.startDate];
      var _endDate = json[EducationSchema.endDate];

      if(_startDate != null && _startDate is String){
        _startDate = Timestamp.fromDate(DateTime.parse(_startDate));
      }

      if(_endDate != null && _endDate is String){
        _endDate = Timestamp.fromDate(DateTime.parse(_endDate));
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
              ? List<Skill>.from(
              json[WorkerHistorySchema.skills].map((x) => Skill.fromJson(x)))
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
              ? Occupation.fromJson(json[WorkerHistorySchema.occupation])
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
          summary: json[WorkerHistorySchema.summary]
      );
    }catch(e,s){
      print("work history education combine catch_____${e}______$s");
      return null;
    }
  }
}

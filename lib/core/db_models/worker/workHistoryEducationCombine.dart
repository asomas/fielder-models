import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/worker/education/education.dart';
import 'package:fielder_models/core/db_models/worker/locationModel.dart';
import 'package:fielder_models/core/db_models/worker/schema/educationSchema.dart';
import 'package:fielder_models/core/db_models/worker/schema/workerHistorySchema.dart';
import 'package:fielder_models/core/db_models/worker/workHistory/workHistory.dart';

class WorkHistoryEducationCombine {
  String docId;
  WorkerType workerType;
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

  WorkHistoryEducationCombine(
      {this.docId,
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
      this.workerType});

  factory WorkHistoryEducationCombine.fromJson(Map<String, dynamic> json,
          {String docId}) =>
      WorkHistoryEducationCombine(
        docId: docId,
        endDate: json[EducationSchema.endDate] != null
            ? json[EducationSchema.endDate]
            : null,
        startDate: json[EducationSchema.startDate] != null
            ? json[EducationSchema.startDate]
            : null,
        location: json[EducationSchema.locationData] != null
            ? LocationModelDetail.fromJson(json[EducationSchema.locationData])
            : null,
        organisationName: json[WorkerHistorySchema.organisationName] != null
            ? json[WorkerHistorySchema.organisationName]
            : "",
        jobTitle: json[WorkerHistorySchema.jobTitle] ?? "",
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
      );
}

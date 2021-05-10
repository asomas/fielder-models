import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/worker/locationModel.dart';
import 'package:fielder_models/core/db_models/worker/schema/educationSchema.dart';

class Education {
  String docId;
  EducationInstitution educationInstitution;
  Timestamp endDate;
  Timestamp startDate;
  LocationModelDetail location;
  Course course;
  bool award;
  Level level;
  String type;
  Grade grade;
  List<KnowledgeArea> knowledgeAreaList;
  String summary;
  DocumentReference workerRef;

  Education(
      {this.docId,
      this.educationInstitution,
      this.endDate,
      this.startDate,
      this.location,
      this.course,
      this.award,
      this.level,
      this.grade,
      this.knowledgeAreaList,
      this.summary,
      this.workerRef});

  static DocumentReference documentReferenceFromString(
      String stringDocumentReference) {
    List<String> splitReference = stringDocumentReference.split("/");
    return FirebaseFirestore.instance
        .collection(splitReference[0])
        .doc(splitReference[1]);
  }

  bool checkAllFieldsNull() {
    if (endDate != null ||
        location != null ||
        educationInstitution != null ||
        course != null ||
        award != null ||
        startDate != null ||
        summary != "" ||
        level != null ||
        grade != null ||
        knowledgeAreaList.length > 0) {
      return false;
    } else {
      return true;
    }
  }

  factory Education.fromJson(Map<String, dynamic> json, {String docId}) {
    var _endDate, _startDate;
    _endDate = json[EducationSchema.endDate];
    _startDate = json[EducationSchema.startDate];
    if (_endDate != null && _endDate is String) {
      String split = _endDate.toString().split("T")[0];
      _endDate = Timestamp.fromDate(DateTime.parse(split));
    }
    if (_startDate != null && _startDate is String) {
      String split = _startDate.toString().split("T")[0];
      _startDate = Timestamp.fromDate(DateTime.parse(split));
    }
    return Education(
        docId: docId,
        educationInstitution: json[EducationSchema.institution] != null
            ? EducationInstitution.fromJson(json[EducationSchema.institution])
            : null,
        endDate: _endDate,
        startDate: _startDate,
        award: json[EducationSchema.award] != null
            ? json[EducationSchema.award]
            : null,
        location: json[EducationSchema.locationData] != null
            ? LocationModelDetail.fromJson(json[EducationSchema.locationData])
            : null,
        course: json[EducationSchema.course] != null
            ? Course.fromJson(json[EducationSchema.course])
            : null,
        level: json[EducationSchema.level] != null
            ? Level.fromJson(json[EducationSchema.level])
            : null,
        grade: json[EducationSchema.grade] != null
            ? Grade.fromJson(json[EducationSchema.grade])
            : null,
        knowledgeAreaList: json[EducationSchema.knowledgeAreas] != null
            ? List<KnowledgeArea>.from(json[EducationSchema.knowledgeAreas]
                .map((x) => KnowledgeArea.fromJson(x)))
            : [],
        summary: json[EducationSchema.summary] != null
            ? json[EducationSchema.summary]
            : "",
        workerRef: json[EducationSchema.workerRef] != null
            ? json[EducationSchema.workerRef] is String
                ? documentReferenceFromString(json[EducationSchema.workerRef])
                : json[EducationSchema.workerRef]
            : null);
  }
}

class Course {
  DocumentReference courseRef;
  String value;
  String courseId;

  Course({this.courseRef, this.value, this.courseId});

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        courseRef: json[EducationSchema.courseRef] != null
            ? json[EducationSchema.courseRef] is String
                ? Education.documentReferenceFromString(
                    json[EducationSchema.courseRef])
                : json[EducationSchema.courseRef]
            : null,
        value: json[EducationSchema.value] ?? "",
        courseId: json[EducationSchema.courseId] ?? "",
      );

  Map<String, dynamic> toJson() => {
        EducationSchema.courseRef: courseRef,
        EducationSchema.value: value,
      };
}

class EducationInstitution {
  DocumentReference institutionRef;
  String institutionId;
  String value;

  EducationInstitution({this.institutionRef, this.value, this.institutionId});

  factory EducationInstitution.fromJson(Map<String, dynamic> json) =>
      EducationInstitution(
        institutionRef: json[EducationSchema.institutionRef] != null
            ? json[EducationSchema.institutionRef] is String
                ? Education.documentReferenceFromString(
                    json[EducationSchema.institutionRef])
                : json[EducationSchema.institutionRef]
            : null,
        value: json[EducationSchema.value] ?? "",
        institutionId: json[EducationSchema.institutionId] ?? "",
      );

  Map<String, dynamic> toJson() => {
        EducationSchema.institutionRef: institutionRef,
        EducationSchema.value: value,
      };
}

class Level {
  DocumentReference levelRef;
  String value;
  String levelId;

  Level({this.levelRef, this.value, this.levelId});

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        levelRef: json[EducationSchema.levelRef] != null
            ? json[EducationSchema.levelRef] is String
                ? Education.documentReferenceFromString(
                    json[EducationSchema.levelRef])
                : json[EducationSchema.levelRef]
            : null,
        value: json[EducationSchema.value] ?? "",
        levelId: json[EducationSchema.levelId] ?? "",
      );

  Map<String, dynamic> toJson() => {
        EducationSchema.levelRef: levelRef,
        EducationSchema.value: value,
      };
}

class Grade {
  DocumentReference gradeRef;
  String value;
  String gradeId;

  Grade({this.gradeRef, this.value, this.gradeId});

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
        gradeRef: json[EducationSchema.gradeRef] != null
            ? json[EducationSchema.gradeRef] is String
                ? Education.documentReferenceFromString(
                    json[EducationSchema.gradeRef])
                : json[EducationSchema.gradeRef]
            : null,
        value: json[EducationSchema.value] ?? "",
        gradeId: json[EducationSchema.gradeId] ?? "",
      );

  Map<String, dynamic> toJson() => {
        EducationSchema.gradeRef: gradeRef,
        EducationSchema.value: value,
      };
}

class KnowledgeArea {
  DocumentReference knowledgeAreaRef;
  String value;
  String knowledgeAreaId;

  KnowledgeArea({this.knowledgeAreaRef, this.value, this.knowledgeAreaId});

  factory KnowledgeArea.fromJson(Map<String, dynamic> json) => KnowledgeArea(
        knowledgeAreaRef: json[EducationSchema.knowledgeAreaRef] != null
            ? json[EducationSchema.knowledgeAreaRef] is String
                ? Education.documentReferenceFromString(
                    json[EducationSchema.knowledgeAreaRef])
                : json[EducationSchema.knowledgeAreaRef]
            : null,
        value: json[EducationSchema.value] ?? "",
        knowledgeAreaId: json[EducationSchema.knowledgeAreaId] ?? "",
      );

  Map<String, dynamic> toJson() => {
        EducationSchema.knowledgeAreaRef: knowledgeAreaRef,
        EducationSchema.value: value,
      };
}

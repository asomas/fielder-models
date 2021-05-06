import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/worker/schema/educationSchema.dart';

class Education {
  EducationInstitution educationInstitution;
  String endDate;
  String startDate;
  String location;
  Course course;
  bool award;
  Level level;
  Grade grade;
  List<KnowledgeArea> knowledgeAreaList;
  String summary;
  DocumentReference workerRef;

  Education(
      {this.educationInstitution,
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

  factory Education.fromJson(Map<String, dynamic> json) => Education(
      educationInstitution: json[EducationSchema.educationInstitution] != null
          ? EducationInstitution.fromJson(
              json[EducationSchema.educationInstitution])
          : null,
      endDate: json[EducationSchema.endDate] != null
          ? json[EducationSchema.endDate]
          : "",
      startDate: json[EducationSchema.startDate] != null
          ? json[EducationSchema.startDate]
          : "",
      award: json[EducationSchema.award] != null
          ? json[EducationSchema.award]
          : false,
      location: json[EducationSchema.location] != null
          ? json[EducationSchema.location]
          : "",
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
          ? json[EducationSchema.workerRef]
          : "");
}

class Course {
  DocumentReference courseRef;
  String value;

  Course({
    this.courseRef,
    this.value,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        courseRef: json[EducationSchema.courseRef],
        value: json[EducationSchema.value],
      );

  Map<String, dynamic> toJson() => {
        EducationSchema.courseRef: courseRef,
        EducationSchema.value: value,
      };
}

class EducationInstitution {
  DocumentReference educationInstitutionRef;
  String value;

  EducationInstitution({
    this.educationInstitutionRef,
    this.value,
  });

  factory EducationInstitution.fromJson(Map<String, dynamic> json) =>
      EducationInstitution(
        educationInstitutionRef: json[EducationSchema.educationInstitutionRef],
        value: json[EducationSchema.value],
      );

  Map<String, dynamic> toJson() => {
        EducationSchema.educationInstitutionRef: educationInstitutionRef,
        EducationSchema.value: value,
      };
}

class Level {
  DocumentReference levelRef;
  String value;

  Level({
    this.levelRef,
    this.value,
  });

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        levelRef: json[EducationSchema.levelRef],
        value: json[EducationSchema.value],
      );

  Map<String, dynamic> toJson() => {
        EducationSchema.levelRef: levelRef,
        EducationSchema.value: value,
      };
}

class Grade {
  DocumentReference gradeRef;
  String value;

  Grade({
    this.gradeRef,
    this.value,
  });

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
        gradeRef: json[EducationSchema.gradeRef],
        value: json[EducationSchema.value],
      );

  Map<String, dynamic> toJson() => {
        EducationSchema.gradeRef: gradeRef,
        EducationSchema.value: value,
      };
}

class KnowledgeArea {
  DocumentReference knowledgeAreaRef;
  String value;

  KnowledgeArea({
    this.knowledgeAreaRef,
    this.value,
  });

  factory KnowledgeArea.fromJson(Map<String, dynamic> json) => KnowledgeArea(
        knowledgeAreaRef: json[EducationSchema.knowledgeAreaRef],
        value: json[EducationSchema.value],
      );

  Map<String, dynamic> toJson() => {
        EducationSchema.knowledgeAreaRef: knowledgeAreaRef,
        EducationSchema.value: value,
      };
}

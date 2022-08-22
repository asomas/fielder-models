import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/qualification_model.dart';
import 'package:fielder_models/core/db_models/old/schema/job_summary_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/qualifications_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/table_collection_schema.dart';
import 'package:fielder_models/core/db_models/worker/education/education.dart';
import 'package:fielder_models/core/db_models/worker/schema/educationSchema.dart';
import 'package:flutter/cupertino.dart';

class CoursesAndLevelModel {
  QualificationModel course;
  Level level;
  Grade grade;

  CoursesAndLevelModel(
      {@required this.course, @required this.level, @required this.grade});

  factory CoursesAndLevelModel.fromMap(Map map) {
    if (map != null && map.isNotEmpty) {
      num _levelNumber;
      String _levelValue, _courseValue;
      if (map.containsKey(JobSummarySchema.courseData) &&
          map[JobSummarySchema.courseData] != null) {
        _courseValue =
            map[JobSummarySchema.courseData][QualificationsSchema.value];
      }
      if (map.containsKey(JobSummarySchema.levelData) &&
          map[JobSummarySchema.levelData] != null) {
        _levelValue = map[JobSummarySchema.levelData][EducationSchema.value];
        _levelNumber =
            map[JobSummarySchema.levelData][EducationSchema.levelNumber];
      }
      try {
        return CoursesAndLevelModel(
          course: QualificationModel(
            docID: (map[JobSummarySchema.courseRef] as DocumentReference)?.id,
            value: _courseValue ?? '',
          ),
          level: Level(
            levelId: (map[EducationSchema.levelRef] as DocumentReference)?.id,
            levelRef: (map[EducationSchema.levelRef] as DocumentReference),
            levelNumber: _levelNumber,
            value: _levelValue ?? '',
          ),
          grade: Grade(
            gradeId: (map[EducationSchema.gradeRef] as DocumentReference)?.id,
            gradeRef: (map[EducationSchema.gradeRef] as DocumentReference),
            //gradeNumber:
          ),
        );
      } catch (e, s) {
        print("courses level model catch___${e}____$s");
        return null;
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      JobSummarySchema.courseRef:
          course?.docID != null ? _getCourseRef(course?.docID) : null,
      JobSummarySchema.levelRef: level?.levelRef ?? level?.levelId != null
          ? _getLevelRef(level?.levelId)
          : null,
      JobSummarySchema.gradeRef: grade?.gradeRef ?? grade?.gradeId != null
          ? _getGradeRef(grade?.gradeId)
          : null,
    };
  }

  Map<String, dynamic> toJsonForApi() {
    Map<String, dynamic> dataMap = {};
    if (course?.docID != null) {
      dataMap[JobSummarySchema.courseRef] =
          '${JobSummarySchema.courses}/${course.docID}';
    }
    if (level?.levelId != null) {
      dataMap[JobSummarySchema.levelRef] =
          "${JobSummarySchema.levels}/${level.levelId}";
    }
    if (grade?.gradeId != null) {
      dataMap[JobSummarySchema.gradeRef] =
          "${FbCollections.grades}/${grade.gradeId}";
    }
    return dataMap;
  }

  Map<String, dynamic> toJsonForMatching() {
    Map<String, dynamic> dataMap = {};
    if (course?.docID != null) {
      dataMap[EducationSchema.courseId] = course.docID;
    }
    if (level?.levelId != null) {
      dataMap[EducationSchema.levelId] = level.levelId;
    }
    if (level?.levelNumber != null) {
      dataMap[EducationSchema.levelNumber] = level.levelNumber;
    }
    if (grade?.gradeId != null) {
      dataMap[EducationSchema.gradeId] = grade.gradeId;
    }
    if (grade?.gradeNumber != null) {
      dataMap[EducationSchema.gradeNumber] = grade.gradeNumber;
    }
    return dataMap;
  }

  DocumentReference _getCourseRef(String id) {
    return FirebaseFirestore.instance.collection(FbCollections.courses).doc(id);
  }

  DocumentReference _getLevelRef(String id) {
    return FirebaseFirestore.instance.collection(FbCollections.levels).doc(id);
  }

  DocumentReference _getGradeRef(String id) {
    return FirebaseFirestore.instance.collection(FbCollections.grades).doc(id);
  }
}

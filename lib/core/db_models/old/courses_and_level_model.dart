import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/qualification_model.dart';
import 'package:fielder_models/core/db_models/old/schema/job_summary_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/qualifications_schema.dart';
import 'package:fielder_models/core/db_models/worker/education/education.dart';
import 'package:fielder_models/core/db_models/worker/schema/educationSchema.dart';
import 'package:flutter/cupertino.dart';

class CoursesAndLevelModel {
  QualificationModel course;
  Level level;

  CoursesAndLevelModel({@required this.course, @required this.level});

  factory CoursesAndLevelModel.fromMap(Map map) {
    if (map != null && map.isNotEmpty) {
      int _levelNumber;
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
              value: _levelValue ?? ''),
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
    };
  }

  Map<String, dynamic> toJsonForApi() {
    return {
      JobSummarySchema.courseRef: course?.docID != null
          ? '${JobSummarySchema.courses}/${course.docID}'
          : null,
      JobSummarySchema.levelRef: level?.levelId != null
          ? "${JobSummarySchema.levels}/${level.levelId}"
          : null,
    };
  }

  DocumentReference _getCourseRef(String id) {
    return FirebaseFirestore.instance.collection('courses').doc(id);
  }

  DocumentReference _getLevelRef(String id) {
    return FirebaseFirestore.instance.collection('levels').doc(id);
  }
}

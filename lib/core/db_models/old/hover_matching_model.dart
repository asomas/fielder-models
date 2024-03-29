import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/old/schema/candidates_matching_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/worker_checks_schema.dart';
import 'package:fielder_models/core/enums/enums.dart';

import '../helpers/date_time_helper.dart';

class HoverMatchingModel {
  String id;
  List<AvailabilityMatching> availability;
  List<SkillsMatching> skills;
  List<ChecksMatching> checks;
  List<CoursesMatching> courses;

  HoverMatchingModel(
      {this.id, this.availability, this.skills, this.checks, this.courses});

  factory HoverMatchingModel.fromMap(Map map) {
    try {
      return HoverMatchingModel(
        id: map[HoverMatchingSchema.id],
        availability:
            (map[HoverMatchingSchema.availabilities] as Map<String, dynamic>)
                ?.entries
                ?.map((e) => AvailabilityMatching.fromList(e))
                ?.toList(),
        skills: (map[HoverMatchingSchema.skills] as Map<String, dynamic>)
            ?.entries
            ?.map((e) => SkillsMatching.fromList(e))
            ?.toList(),
        checks: (map[HoverMatchingSchema.checks] as Map<String, dynamic>)
            ?.entries
            ?.map((e) => ChecksMatching.fromList(e))
            ?.toList(),
        courses: (map[HoverMatchingSchema.courses] as Map<String, dynamic>)
            ?.entries
            ?.map((e) => CoursesMatching.fromList(e))
            ?.toList(),
      );
    } catch (e, s) {
      print("hover matching model catch____${e}____$s");
      return null;
    }
  }
}

class AvailabilityMatching {
  String date;
  bool valid;

  AvailabilityMatching({this.date, this.valid});

  factory AvailabilityMatching.fromList(MapEntry map) {
    return AvailabilityMatching(date: map.key, valid: map.value ?? false);
  }
}

class SkillsMatching {
  String skillId;
  bool valid;
  String value;

  SkillsMatching({this.skillId, this.valid, this.value});

  factory SkillsMatching.fromList(MapEntry map) {
    return SkillsMatching(skillId: map.key, valid: map.value ?? false);
  }
}

class ChecksMatching {
  String checkName;
  CheckStatus status;
  DateTime expectedCompletionDate;

  ChecksMatching({this.checkName, this.status, this.expectedCompletionDate});

  factory ChecksMatching.fromList(MapEntry map) {
    if (map.value is Map) {
      Map<String, dynamic> value = map?.value;
      return ChecksMatching(
        checkName: map?.key,
        status:
            EnumHelpers.checkStatusFromString(value[WorkerChecksSchema.status]),
        expectedCompletionDate: DateTimeHelper.timeStampFromString(
                value[WorkerChecksSchema.expectedCompletionAt])
            ?.toDate(),
      );
    } else {
      return ChecksMatching(
        checkName: map?.key,
        status: CheckStatus.NotStarted,
        expectedCompletionDate: null,
      );
    }
  }
}

class CoursesMatching {
  String courseId;
  String levelId;
  String gradeId;
  bool valid;
  String courseValue;
  String levelValue;
  String gradeValue;

  CoursesMatching({
    this.courseId,
    this.levelId,
    this.gradeId,
    this.valid,
    this.courseValue,
    this.levelValue,
    this.gradeValue,
  });

  factory CoursesMatching.fromList(MapEntry map) {
    List<String> courseLevel = map?.key?.toString()?.split('_');
    return CoursesMatching(
      courseId: courseLevel[0],
      levelId: courseLevel[1],
      gradeId: courseLevel[2],
      valid: map?.value ?? false,
    );
  }
}

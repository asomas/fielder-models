import 'package:fielder_models/core/db_models/old/schema/candidates_matching_schema.dart';

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
        availability: (map[HoverMatchingSchema.availabilities] as List)
            ?.map((e) => AvailabilityMatching.fromList(e))
            ?.toList(),
        skills: (map[HoverMatchingSchema.skills] as List)
            ?.map((e) => SkillsMatching.fromList(e))
            ?.toList(),
        checks: (map[HoverMatchingSchema.checks] as List)
            ?.map((e) => ChecksMatching.fromList(e))
            ?.toList(),
        courses: (map[HoverMatchingSchema.courses] as List)
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

  factory AvailabilityMatching.fromList(List list) {
    return AvailabilityMatching(date: list[0], valid: list[1] ?? false);
  }
}

class SkillsMatching {
  String skillId;
  bool valid;
  String value;

  SkillsMatching({this.skillId, this.valid, this.value});

  factory SkillsMatching.fromList(List list) {
    return SkillsMatching(skillId: list[0], valid: list[1] ?? false);
  }
}

class ChecksMatching {
  String checkId;
  bool valid;
  String value;

  ChecksMatching({this.checkId, this.valid, this.value});

  factory ChecksMatching.fromList(List list) {
    return ChecksMatching(checkId: list[0], valid: list[1] ?? false);
  }
}

class CoursesMatching {
  String courseId;
  String levelId;
  bool valid;
  String courseValue;
  String levelValue;

  CoursesMatching(
      {this.courseId,
      this.levelId,
      this.valid,
      this.courseValue,
      this.levelValue});

  factory CoursesMatching.fromList(List list) {
    return CoursesMatching(
        courseId: list[0][0], levelId: list[0][1], valid: list[1] ?? false);
  }
}

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
      print("hover matching catch____${e}____$s");
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

  SkillsMatching({this.skillId, this.valid});

  factory SkillsMatching.fromList(List list) {
    return SkillsMatching(skillId: list[0], valid: list[1] ?? false);
  }
}

class ChecksMatching {
  String checkId;
  bool valid;

  ChecksMatching({this.checkId, this.valid});

  factory ChecksMatching.fromList(List list) {
    return ChecksMatching(checkId: list[0], valid: list[1] ?? false);
  }
}

class CoursesMatching {
  String courseId;
  String levelId;
  bool valid;

  CoursesMatching({this.courseId, this.levelId, this.valid});

  factory CoursesMatching.fromList(List list) {
    return CoursesMatching(
        courseId: list[0], levelId: list[1], valid: list[2] ?? false);
  }
}

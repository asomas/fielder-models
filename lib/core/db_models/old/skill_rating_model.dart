import 'package:fielder_models/core/db_models/old/schema/skill_rating_schema.dart';

class SkillRatingModel {
  List<RateSkill> transferable;
  List<RateSkill> specialized;

  SkillRatingModel({this.transferable, this.specialized});

  factory SkillRatingModel.fromMap(Map map) {
    if (map != null && map.isNotEmpty) {
      try {
        return SkillRatingModel(
          transferable: map[SkillRatingSchema.transferable] != null
              ? List<RateSkill>.from(map[SkillRatingSchema.transferable]
                  .map((x) => RateSkill.fromMap(x)))
              : [],
          specialized: map[SkillRatingSchema.specialized] != null
              ? List<RateSkill>.from(map[SkillRatingSchema.specialized]
                  .map((x) => RateSkill.fromMap(x)))
              : [],
        );
      } catch (e, s) {
        print("SKills rating model catch_____${e}_____$s");
        return null;
      }
    }
    return null;
  }
}

class RateSkill {
  String id;
  String description;
  String value;
  num transferability;

  RateSkill({this.id, this.description, this.value, this.transferability});

  factory RateSkill.fromMap(Map map) {
    if (map != null && map.isNotEmpty) {
      try {
        return RateSkill(
          id: map[SkillRatingSchema.id],
          description: map[SkillRatingSchema.description],
          value: map[SkillRatingSchema.value],
          transferability: map[SkillRatingSchema.transferability],
        );
      } catch (e, s) {
        print("Rate skills catch_____${e}______$s");
        return null;
      }
    }
    return null;
  }
}

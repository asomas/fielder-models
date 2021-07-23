import 'package:fielder_models/core/db_models/old/schema/candidates_matching_schema.dart';

class CandidatesModel {
  String workerId;
  String firstName;
  String lastName;
  String fullName;
  String pictureUrl;
  bool isStaff;
  double skillScore;
  double qualificationScore;
  double checkScore;
  double availabilityScore;
  double totalScore;

  CandidatesModel({
    this.workerId,
    this.isStaff,
    this.firstName,
    this.lastName,
    this.fullName,
    this.pictureUrl,
    this.skillScore = 0,
    this.qualificationScore = 0,
    this.checkScore = 0,
    this.availabilityScore = 0,
    this.totalScore = 0,
  });

  factory CandidatesModel.fromMap(Map<String, dynamic> map) {
    return CandidatesModel(
      workerId: map[CandidatesMatchingSchema.workerId],
      isStaff: map[CandidatesMatchingSchema.isStaff],
      firstName: map[CandidatesMatchingSchema.firstName],
      lastName: map[CandidatesMatchingSchema.lastName],
      fullName: "${map[CandidatesMatchingSchema.firstName] ?? ""}"
          " ${map[CandidatesMatchingSchema.lastName] ?? ""}",
      pictureUrl: map[CandidatesMatchingSchema.pictureUrl],
    );
  }

  factory CandidatesModel.fromMatching(Map<String, dynamic> map, bool isStaff,
      String firstName, String lastName, String avatarUrl) {
    try {
      return CandidatesModel(
        workerId: map[CandidatesMatchingSchema.id],
        skillScore: map[CandidatesMatchingSchema.skillsScore],
        qualificationScore: map[CandidatesMatchingSchema.qualificationsScore],
        checkScore: map[CandidatesMatchingSchema.checksScore],
        availabilityScore: map[CandidatesMatchingSchema.availabilityScore],
        totalScore: map[CandidatesMatchingSchema.overallScore],
        isStaff: isStaff,
        firstName: firstName,
        lastName: lastName,
        fullName: "${firstName ?? ""} ${lastName ?? ""}",
        pictureUrl: avatarUrl,
      );
    } catch (e) {
      print("candidates matching model catch_______$e");
      return null;
    }
  }
}

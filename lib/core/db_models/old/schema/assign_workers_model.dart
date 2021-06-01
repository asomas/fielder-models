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

  CandidatesModel(
      {this.workerId,
      this.isStaff,
      this.firstName,
      this.lastName,
      this.fullName,
      this.pictureUrl,
      this.skillScore = 0,
      this.qualificationScore = 0,
      this.checkScore = 0,
      this.availabilityScore = 0 ,
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

  factory CandidatesModel.fromMatching(Map<String, dynamic> map,
      bool isStaff, String firstName, String lastName, String avatarUrl) {
    return CandidatesModel(
      workerId: map[CandidatesMatchingSchema.id],
      skillScore: double.parse(map[CandidatesMatchingSchema.skillsScore]??0),
      qualificationScore: double.parse(map[CandidatesMatchingSchema.qualificationsScore]??0),
      checkScore: double.parse(map[CandidatesMatchingSchema.checksScore]??0),
      availabilityScore: double.parse(map[CandidatesMatchingSchema.availabilityScore]??0),
      totalScore: double.parse(map[CandidatesMatchingSchema.overallScore]??0),
      isStaff: isStaff,
      firstName: firstName,
      lastName: lastName,
      fullName: "${firstName ?? ""} ${lastName ?? ""}",
      pictureUrl: avatarUrl,
    );
  }
}

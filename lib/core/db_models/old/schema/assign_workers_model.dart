import 'package:fielder_models/core/db_models/old/invite%20_status_model.dart';
import 'package:fielder_models/core/db_models/old/schema/candidates_matching_schema.dart';

class CandidatesModel {
  String workerId;
  String firstName;
  String lastName;
  String fullName;
  String phoneNumber;
  String pictureUrl;
  bool isStaff;
  double skillScore;
  double coursesScore;
  double checkScore;
  double availabilityScore;
  double totalScore;
  InviteStatusModel fielderNetworkInvite;
  bool isGhostUser;
  double distance;
  bool hasLoggedIn;

  CandidatesModel({
    this.workerId,
    this.isStaff,
    this.firstName,
    this.lastName,
    this.fullName,
    this.phoneNumber,
    this.pictureUrl,
    this.skillScore = 0,
    this.coursesScore = 0,
    this.checkScore = 0,
    this.availabilityScore = 0,
    this.totalScore = 0,
    this.fielderNetworkInvite,
    this.isGhostUser = false,
    this.distance = 0,
    this.hasLoggedIn,
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
        distance: map[CandidatesMatchingSchema.distance]);
  }

  factory CandidatesModel.fromMatching(Map<String, dynamic> map, bool isStaff,
      String firstName, String lastName, String avatarUrl, String phoneNumber) {
    try {
      return CandidatesModel(
          workerId: map[CandidatesMatchingSchema.id],
          skillScore: map[CandidatesMatchingSchema.skillsScore],
          coursesScore: map[CandidatesMatchingSchema.coursesScore],
          checkScore: map[CandidatesMatchingSchema.checksScore],
          availabilityScore: map[CandidatesMatchingSchema.availabilityScore],
          totalScore: map[CandidatesMatchingSchema.overallScore],
          isStaff: isStaff,
          firstName: firstName,
          lastName: lastName,
          fullName: "${firstName ?? ""} ${lastName ?? ""}",
          pictureUrl: avatarUrl,
          phoneNumber: phoneNumber,
          distance: map[CandidatesMatchingSchema.distance]);
    } catch (e) {
      print("candidates matching model catch_______$e");
      return null;
    }
  }

  factory CandidatesModel.forFielderNetwork(
    Map<String, dynamic> map,
    bool isStaff,
    String firstName,
    String lastName,
    String avatarUrl,
    String phoneNumber, {
    InviteStatusModel invite,
    bool isGhostUser,
    bool hasLoggedIn,
  }) {
    try {
      return CandidatesModel(
        workerId: map[CandidatesMatchingSchema.id],
        skillScore: map[CandidatesMatchingSchema.skillsScore],
        coursesScore: map[CandidatesMatchingSchema.coursesScore],
        checkScore: map[CandidatesMatchingSchema.checksScore],
        availabilityScore: map[CandidatesMatchingSchema.availabilityScore],
        totalScore: map[CandidatesMatchingSchema.overallScore],
        isStaff: isStaff,
        firstName: firstName,
        lastName: lastName,
        fullName: "${firstName ?? ""} ${lastName ?? ""}",
        pictureUrl: avatarUrl,
        phoneNumber: phoneNumber,
        fielderNetworkInvite: invite,
        isGhostUser: isGhostUser,
        distance: map[CandidatesMatchingSchema.distance],
        hasLoggedIn: hasLoggedIn,
      );
    } catch (e) {
      print("candidates matching model catch_______$e");
      return null;
    }
  }

  Map<String, dynamic> rawJson() {
    return {
      CandidatesMatchingSchema.id: workerId,
      CandidatesMatchingSchema.skillsScore: skillScore,
      CandidatesMatchingSchema.coursesScore: coursesScore,
      CandidatesMatchingSchema.checksScore: checkScore,
      CandidatesMatchingSchema.availabilityScore: availabilityScore,
      CandidatesMatchingSchema.overallScore: totalScore,
      CandidatesMatchingSchema.distance: distance,
    };
  }
}

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
        workerId: map["worker_id"],
        isStaff: map["is_staff"],
        firstName: map["first_name"],
        lastName: map["last_name"],
        fullName: "${map["first_name"] ?? ""} ${map["last_name"] ?? ""}",
        pictureUrl: map["picture_url"],
        skillScore: map["skills_score"]?.toDouble(),
        qualificationScore: map["qualifications_score"]?.toDouble(),
        checkScore: map["checks_score"]?.toDouble(),
        availabilityScore: map["availability_score"]?.toDouble() ,
        totalScore: map["overall_match_score"]?.toDouble(),
    );
  }

  factory CandidatesModel.fromMatching(Map<String, dynamic> map,
      bool isStaff, String firstName, String lastName, String avatarUrl) {
    return CandidatesModel(
      workerId: map["id"],
      skillScore: double.parse(map["skills_score"]??0),
      qualificationScore: double.parse(map["qualifications_score"]??0),
      checkScore: double.parse(map["checks_score"]??0),
      availabilityScore: double.parse(map["availability_score"]??0),
      totalScore: double.parse(map["overall_score"]??0),
      isStaff: isStaff,
      firstName: firstName,
      lastName: lastName,
      fullName: "${firstName ?? ""} ${lastName ?? ""}",
      pictureUrl: avatarUrl,
    );
  }
}

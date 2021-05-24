class CandidatesModel {
  String workerId;
  String firstName;
  String lastName;
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
        pictureUrl: map["picture_url"],
        skillScore: map["skills_score"]?.toDouble(),
        qualificationScore: map["qualifications_score"]?.toDouble(),
        checkScore: map["checks_score"]?.toDouble(),
        availabilityScore: map["availability_score"]?.toDouble() ,
        totalScore: map["overall_match_score"]?.toDouble(),
    );
  }
}

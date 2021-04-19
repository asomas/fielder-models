import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/worker/schema/workerHistorySchema.dart';

class WorkHistory {
  List<Check> checks;
  String endDate;
  String startDate;
  String location;
  Occupation occupation;
  String organisationName;
  List<Qualification> qualifications;
  SicCode sicCode;
  List<Skill> skills;
  String summary;
  DocumentReference workerRef;

  WorkHistory({this.checks,
    this.endDate,
    this.location,
    this.occupation,
    this.organisationName,
    this.qualifications,
    this.sicCode,
    this.skills,
    this.startDate,
    this.summary,
    this.workerRef});

  bool checkAllFieldsNull() {
    return [
      endDate,
      location,
      occupation,
      organisationName,
      sicCode,
      startDate,
      summary
    ].any((element) {
      if (element != "" && element != null) {
        return false;
      } else {
        if (checks.length > 0 || qualifications.length > 0 ||
            skills.length > 0) {
          return false;
        } else {
          return true;
        }
      }
    });
  }

  factory WorkHistory.fromJson(Map<String, dynamic> json) =>
      WorkHistory(
          checks: json[WorkerHistorySchema.checks] != null
              ? List<Check>.from(
              json[WorkerHistorySchema.checks].map((x) => Check.fromJson(x)))
              : [],
          endDate: json[WorkerHistorySchema.endDate] != null
              ? json[WorkerHistorySchema.endDate]
              : "",
          startDate: json[WorkerHistorySchema.startDate] != null
              ? json[WorkerHistorySchema.startDate]
              : "",
          location: json[WorkerHistorySchema.location] != null
              ? json[WorkerHistorySchema.location]
              : "",
          occupation: json[WorkerHistorySchema.occupation] != null
              ? Occupation.fromJson(json[WorkerHistorySchema.occupation])
              : null,
          organisationName: json[WorkerHistorySchema.organisationName] != null
              ? json[WorkerHistorySchema.organisationName]
              : "",
          qualifications: json[WorkerHistorySchema.qualifications] != null
              ? List<Qualification>.from(
              json[WorkerHistorySchema.qualifications].map((x) =>
                  Qualification.fromJson(x)))
              : [],
          sicCode: json[WorkerHistorySchema.sic_code] != null
              ? SicCode.fromJson(json[WorkerHistorySchema.sic_code])
              : null,
          skills: json[WorkerHistorySchema.skills] != null
              ? List<Skill>.from(
              json[WorkerHistorySchema.skills].map((x) => Skill.fromJson(x)))
              : [],
          summary: json[WorkerHistorySchema.summary] != null
              ? json[WorkerHistorySchema.summary]
              : "",
          workerRef: json[WorkerHistorySchema.workerRef] != null
              ? json[WorkerHistorySchema.workerRef]
              : "");
}

class Occupation {
  DocumentReference occupationRef;
  String value;

  Occupation({
    this.occupationRef,
    this.value,
  });

  factory Occupation.fromJson(Map<String, dynamic> json) =>
      Occupation(
        occupationRef: json[WorkerHistorySchema.occupationRef],
        value: json[WorkerHistorySchema.value],
      );

  Map<String, dynamic> toJson() =>
      {
        WorkerHistorySchema.occupationRef: occupationRef,
        WorkerHistorySchema.value: value,
      };
}

class Check {
  DocumentReference checkRef;
  String value;

  Check({
    this.checkRef,
    this.value,
  });

  factory Check.fromJson(Map<String, dynamic> json) =>
      Check(
        checkRef: json[WorkerHistorySchema.checkRef],
        value: json[WorkerHistorySchema.value],
      );

  Map<String, dynamic> toJson() =>
      {
        WorkerHistorySchema.checkRef: checkRef,
        WorkerHistorySchema.value: value,
      };
}

class Qualification {
  DocumentReference qualificationRef;
  String value;

  Qualification({
    this.qualificationRef,
    this.value,
  });

  factory Qualification.fromJson(Map<String, dynamic> json) =>
      Qualification(
        qualificationRef: json[WorkerHistorySchema.qualificationRef],
        value: json[WorkerHistorySchema.value],
      );

  Map<String, dynamic> toJson() =>
      {
        WorkerHistorySchema.qualificationRef: qualificationRef,
        WorkerHistorySchema.value: value,
      };
}

class SicCode {
  DocumentReference sicCodeRef;
  String value;

  SicCode({
    this.sicCodeRef,
    this.value,
  });

  factory SicCode.fromJson(Map<String, dynamic> json) =>
      SicCode(
        sicCodeRef: json[WorkerHistorySchema.sicCodeRef],
        value: json[WorkerHistorySchema.value],
      );

  Map<String, dynamic> toJson() =>
      {
        WorkerHistorySchema.sicCodeRef: sicCodeRef,
        WorkerHistorySchema.value: value,
      };
}

class Skill {
  DocumentReference skillRef;
  String value;

  Skill({
    this.skillRef,
    this.value,
  });

  factory Skill.fromJson(Map<String, dynamic> json) =>
      Skill(
        skillRef: json[WorkerHistorySchema.skillRef],
        value: json[WorkerHistorySchema.value],
      );

  Map<String, dynamic> toJson() =>
      {
        WorkerHistorySchema.occupationRef: skillRef,
        WorkerHistorySchema.value: value,
      };
}

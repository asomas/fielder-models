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
  String docId;

  WorkHistory(
      {this.checks,
      this.endDate,
      this.location,
      this.occupation,
      this.organisationName,
      this.qualifications,
      this.sicCode,
      this.skills,
      this.startDate,
      this.summary,
      this.workerRef,
      this.docId});

  static DocumentReference documentReferenceFromString(
      String stringDocumentReference) {
    List<String> splitReference = stringDocumentReference.split("/");
    return FirebaseFirestore.instance
        .collection(splitReference[0])
        .doc(splitReference[1]);
  }

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
      if (element != null && element != "") {
        return false;
      } else {
        if (checks.length > 0 ||
            qualifications.length > 0 ||
            skills.length > 0) {
          return false;
        } else {
          return true;
        }
      }
    });
  }

  factory WorkHistory.fromJson(Map<String, dynamic> json, {String docId}) =>
      WorkHistory(
          docId: docId,
          checks: json[WorkerHistorySchema.checks] != null
              ? List<Check>.from(json[WorkerHistorySchema.checks]
                  .map((x) => Check.fromJson(x)))
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
                  json[WorkerHistorySchema.qualifications]
                      .map((x) => Qualification.fromJson(x)))
              : [],
          sicCode: json[WorkerHistorySchema.sic_code] != null
              ? SicCode.fromJson(json[WorkerHistorySchema.sic_code])
              : null,
          skills: json[WorkerHistorySchema.skills] != null
              ? List<Skill>.from(json[WorkerHistorySchema.skills]
                  .map((x) => Skill.fromJson(x)))
              : [],
          summary: json[WorkerHistorySchema.summary] != null
              ? json[WorkerHistorySchema.summary]
              : "",
          workerRef: json[WorkerHistorySchema.workerRef] != null
              ? json[WorkerHistorySchema.workerRef] is String
                  ? documentReferenceFromString(json[WorkerHistorySchema.workerRef])
                  : json[WorkerHistorySchema.workerRef]
              : null);
}

class Occupation {
  DocumentReference occupationRef;
  String value;

  Occupation({
    this.occupationRef,
    this.value,
  });

  factory Occupation.fromJson(Map<String, dynamic> json) {
    if (json != null && json.isNotEmpty) {
      DocumentReference documentReference;
      if (json[WorkerHistorySchema.occupationRef] is String) {
        documentReference = WorkHistory.documentReferenceFromString(
            json[WorkerHistorySchema.occupationRef]);
      } else {
        documentReference = json[WorkerHistorySchema.occupationRef];
      }
      return Occupation(
          occupationRef: documentReference,
          value: json[WorkerHistorySchema.value] ?? "");
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
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

  factory Check.fromJson(Map<String, dynamic> json) {
    if (json != null && json.isNotEmpty) {
      DocumentReference documentReference;
      if (json[WorkerHistorySchema.checkRef] is String) {
        documentReference = WorkHistory.documentReferenceFromString(
            json[WorkerHistorySchema.checkRef]);
      } else {
        documentReference = json[WorkerHistorySchema.checkRef];
      }
      return Check(
        checkRef: documentReference,
        value: json[WorkerHistorySchema.value] ?? "",
      );
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
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

  factory Qualification.fromJson(Map<String, dynamic> json) {
    if (json != null && json.isNotEmpty) {
      DocumentReference documentReference;
      if (json[WorkerHistorySchema.qualificationRef] is String) {
        documentReference = WorkHistory.documentReferenceFromString(
            json[WorkerHistorySchema.qualificationRef]);
      } else {
        documentReference = json[WorkerHistorySchema.qualificationRef];
      }
      return Qualification(
        qualificationRef: documentReference,
        value: json[WorkerHistorySchema.value] ?? "",
      );
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
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

  factory SicCode.fromJson(Map<String, dynamic> json) {
    if (json != null && json.isNotEmpty) {
      DocumentReference documentReference;
      if (json[WorkerHistorySchema.sicCodeRef] is String) {
        documentReference = WorkHistory.documentReferenceFromString(
            json[WorkerHistorySchema.sicCodeRef]);
      } else {
        documentReference = json[WorkerHistorySchema.sicCodeRef];
      }
      return SicCode(
        sicCodeRef: documentReference,
        value: json[WorkerHistorySchema.value] ?? "",
      );
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
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

  factory Skill.fromJson(Map<String, dynamic> json) {
    if (json != null && json.isNotEmpty) {
      DocumentReference documentReference;
      if (json[WorkerHistorySchema.skillRef] is String) {
        documentReference = WorkHistory.documentReferenceFromString(
            json[WorkerHistorySchema.skillRef]);
      } else {
        documentReference = json[WorkerHistorySchema.skillRef];
      }
      return Skill(
        skillRef: documentReference,
        value: json[WorkerHistorySchema.value],
      );
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
        WorkerHistorySchema.occupationRef: skillRef,
        WorkerHistorySchema.value: value,
      };
}

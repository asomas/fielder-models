import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/worker/locationModel.dart';
import 'package:fielder_models/core/db_models/worker/schema/workerHistorySchema.dart';

enum ExperienceType { EXTERNAL, FIELDER, EDUCATION, GAP }

enum VerificationStatus {
  Unchecked,
  Checked,
  AwaitingVerification,
  Verified,
  Rejected
}

enum RefereeFields { Name, Phone, Position }

class RefereeModel {
  String phone;
  String name;
  String email;
  String position;

  RefereeModel({this.phone, this.name, this.position, this.email});

  factory RefereeModel.fromMap(Map map) {
    try {
      if (map != null && map.isNotEmpty) {
        return RefereeModel(
          name: map[WorkerHistorySchema.contactName],
          position: map[WorkerHistorySchema.contactPosition],
          phone: map[WorkerHistorySchema.contactPhone],
          email: map[WorkerHistorySchema.contactEmail],
        );
      } else {
        return null;
      }
    } catch (e, s) {
      print("RefereeModelCatch______${e}____$s");
      return null;
    }
  }
}

class WorkHistory {
  List<Check> checks;
  Timestamp endDate;
  Timestamp startDate;
  LocationModelDetail location;
  Occupation occupation;
  String organisationName;
  List<Qualification> qualifications;
  List<Skill> skills;
  List<SicCode> sicCode;
  String summary;
  DocumentReference workerRef;
  DocumentReference jobRef;
  String jobTitle;
  String docId;
  ExperienceType workerType;
  double totalHours;
  int totalShifts;
  RefereeModel refereeModel;

  WorkHistory({
    this.checks,
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
    this.jobRef,
    this.workerType,
    this.docId,
    this.jobTitle,
    this.totalHours,
    this.totalShifts,
    this.refereeModel,
  });

  static DocumentReference documentReferenceFromString(
      String stringDocumentReference) {
    List<String> splitReference = stringDocumentReference.split("/");
    return FirebaseFirestore.instance
        .collection(splitReference[0])
        .doc(splitReference[1]);
  }

  bool checkAllFieldsNull() {
    if (endDate != null ||
        location != null ||
        occupation != null ||
        organisationName != "" ||
        startDate != null ||
        summary != "" ||
        sicCode.length > 0 ||
        checks.length > 0 ||
        qualifications.length > 0 ||
        skills.length > 0) {
      return false;
    } else {
      return true;
    }
  }

  factory WorkHistory.fromJson(Map<String, dynamic> json, {String docId}) {
    var _endDate, _startDate;
    _endDate = json[WorkerHistorySchema.endDate];
    _startDate = json[WorkerHistorySchema.startDate];
    if (_endDate != null && _endDate is String) {
      String split = _endDate.toString().split("T")[0];
      _endDate = Timestamp.fromDate(DateTime.parse(split));
    }
    if (_startDate != null && _startDate is String) {
      String split = _startDate.toString().split("T")[0];
      _startDate = Timestamp.fromDate(DateTime.parse(split));
    }
    return WorkHistory(
      docId: docId,
      checks: json[WorkerHistorySchema.checks] != null
          ? List<Check>.from(
              json[WorkerHistorySchema.checks].map((x) => Check.fromJson(x)))
          : [],
      jobTitle: json[WorkerHistorySchema.jobTitle] != null
          ? json[WorkerHistorySchema.jobTitle]
          : "",
      endDate: _endDate,
      startDate: _startDate,
      location: json[WorkerHistorySchema.locationData] != null
          ? LocationModelDetail.fromJson(json[WorkerHistorySchema.locationData])
          : null,
      occupation: json[WorkerHistorySchema.occupation] != null
          ? Occupation.fromJson(json[WorkerHistorySchema.occupation])
          : null,
      organisationName: json[WorkerHistorySchema.organisationName] != null
          ? json[WorkerHistorySchema.organisationName]
          : "",
      qualifications: json[WorkerHistorySchema.qualifications] != null
          ? List<Qualification>.from(json[WorkerHistorySchema.qualifications]
              .map((x) => Qualification.fromJson(x)))
          : [],
      sicCode: json[WorkerHistorySchema.sicCode] != null
          ? List<SicCode>.from(
              json[WorkerHistorySchema.sicCode].map((x) => SicCode.fromJson(x)))
          : [],
      skills: json[WorkerHistorySchema.skills] != null
          ? List<Skill>.from(
              json[WorkerHistorySchema.skills].map((x) => Skill.fromJson(x)))
          : [],
      summary: json[WorkerHistorySchema.summary] != null
          ? json[WorkerHistorySchema.summary]
          : "",
      workerType: getWorkerType(json[WorkerHistorySchema.type]),
      workerRef: json[WorkerHistorySchema.workerRef] != null
          ? json[WorkerHistorySchema.workerRef] is String
              ? documentReferenceFromString(json[WorkerHistorySchema.workerRef])
              : json[WorkerHistorySchema.workerRef]
          : null,
      jobRef: json[WorkerHistorySchema.jobRef] != null
          ? json[WorkerHistorySchema.jobRef] is String
              ? documentReferenceFromString(json[WorkerHistorySchema.jobRef])
              : json[WorkerHistorySchema.jobRef]
          : null,
      totalHours: json[WorkerHistorySchema.totalHours] != null
          ? double.parse(json[WorkerHistorySchema.totalHours].toString())
          : 0,
      totalShifts: json[WorkerHistorySchema.totalShifts] != null
          ? json[WorkerHistorySchema.totalShifts]
          : 0,
      refereeModel:
          RefereeModel.fromMap(json[WorkerHistorySchema.referencingData]),
    );
  }
  static ExperienceType getWorkerType(String type) {
    ExperienceType workerType = ExperienceType.EXTERNAL;
    if (type == WorkerHistorySchema.external) {
      workerType = ExperienceType.EXTERNAL;
    } else if (type == WorkerHistorySchema.fielder) {
      workerType = ExperienceType.FIELDER;
    } else if (type == WorkerHistorySchema.education) {
      workerType = ExperienceType.EDUCATION;
    } else if (type == WorkerHistorySchema.gap) {
      workerType = ExperienceType.GAP;
    }
    return workerType;
  }

  static VerificationStatus verificationStatusFromString(String type) {
    VerificationStatus verificationStatus = VerificationStatus.Unchecked;
    if (type == WorkerHistorySchema.unchecked) {
      verificationStatus = VerificationStatus.Unchecked;
    } else if (type == WorkerHistorySchema.checked) {
      verificationStatus = VerificationStatus.Checked;
    } else if (type == WorkerHistorySchema.awaitingVerification) {
      verificationStatus = VerificationStatus.AwaitingVerification;
    } else if (type == WorkerHistorySchema.verified) {
      verificationStatus = VerificationStatus.Verified;
    } else if (type == WorkerHistorySchema.rejected) {
      verificationStatus = VerificationStatus.Rejected;
    }
    return verificationStatus;
  }

  static String stringFromVerificationStatus(
      VerificationStatus verificationStatus) {
    String status = WorkerHistorySchema.unchecked;
    if (verificationStatus == VerificationStatus.Unchecked) {
      status = WorkerHistorySchema.unchecked;
    } else if (verificationStatus == VerificationStatus.Checked) {
      status = WorkerHistorySchema.checked;
    } else if (verificationStatus == VerificationStatus.AwaitingVerification) {
      status = WorkerHistorySchema.awaitingVerification;
    } else if (verificationStatus == VerificationStatus.Verified) {
      status = WorkerHistorySchema.verified;
    } else if (verificationStatus == VerificationStatus.Rejected) {
      status = WorkerHistorySchema.rejected;
    }
    return status;
  }
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
  String code;
  String description;

  SicCode({
    this.code,
    this.description,
  });

  factory SicCode.fromJson(Map<String, dynamic> json) {
    if (json != null && json.isNotEmpty) {
      return SicCode(
        code: json[WorkerHistorySchema.code] ?? "",
        description: json[WorkerHistorySchema.description] ?? "",
      );
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
        WorkerHistorySchema.code: code,
        WorkerHistorySchema.description: description,
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

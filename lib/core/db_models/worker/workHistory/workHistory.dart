import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/address_model.dart';
import 'package:fielder_models/core/db_models/old/skills_model.dart';
import 'package:fielder_models/core/db_models/worker/locationModel.dart';
import 'package:fielder_models/core/db_models/worker/occupation.dart';
import 'package:fielder_models/core/db_models/worker/schema/workerHistorySchema.dart';

import '../../../enums/enums.dart';
import '../../helpers/date_time_helper.dart';
import '../schema/locationSchema.dart';

class RefereeModel {
  String phone;
  String name;
  String email;
  String position;
  String relationship;

  RefereeModel(
      {this.phone, this.name, this.position, this.email, this.relationship});

  factory RefereeModel.fromMap(Map map) {
    try {
      if (map != null && map.isNotEmpty) {
        return RefereeModel(
          name: map[WorkerHistorySchema.contactName],
          position: map[WorkerHistorySchema.contactPosition],
          phone: map[WorkerHistorySchema.contactPhone],
          email: map[WorkerHistorySchema.contactEmail],
          relationship: map[WorkerHistorySchema.contactRelationship],
        );
      } else {
        return null;
      }
    } catch (e, s) {
      print("RefereeModelCatch______${e}____$s");
      return null;
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      WorkerHistorySchema.contactPhone: phone,
      WorkerHistorySchema.contactName: name,
      WorkerHistorySchema.contactPosition: position,
      WorkerHistorySchema.contactEmail: email,
      WorkerHistorySchema.contactRelationship: relationship,
    };
    map?.removeWhere((key, value) => value == null || value.isEmpty);
    return map;
  }
}

class WorkHistory {
  List<Check> checks;
  Timestamp endDate;
  Timestamp startDate;
  LocationModelDetail location;
  OccupationModel occupation;
  String organisationName;
  List<Qualification> qualifications;
  List<SkillsModel> skills;
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
          ? OccupationModel.fromJson(json[WorkerHistorySchema.occupation])
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
          ? List<SkillsModel>.from(json[WorkerHistorySchema.skills]
              .map((x) => SkillsModel.fromMap(map: x)))
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

  Map<String, dynamic> toJson(AddressModel addressModel, String companyNumber) {
    Map<String, dynamic> map = {
      WorkerHistorySchema.jobTitle: jobTitle,
      WorkerHistorySchema.startDate:
          DateTimeHelper.dateToString(startDate?.toDate()),
      WorkerHistorySchema.endDate:
          DateTimeHelper.dateToString(endDate?.toDate()),
      WorkerHistorySchema.organisationName: organisationName,
      WorkerHistorySchema.companyNumber: companyNumber,
      WorkerHistorySchema.summary: summary ?? '',
      WorkerHistorySchema.referencingData: refereeModel?.toMap(),
    };
    if (addressModel != null) {
      map[WorkerHistorySchema.locationData] = {
        LocationSchema.address: addressModel?.toJSON()
      };
    }
    if (occupation != null) {
      map[WorkerHistorySchema.occupation] = occupation?.toJson();
    }
    if (qualifications != null) {
      map[WorkerHistorySchema.qualifications] =
          qualifications?.map((e) => e?.toJson())?.toList();
    }
    if (skills != null) {
      map[WorkerHistorySchema.skills] =
          skills?.map((e) => e?.toJSON())?.toList();
    }
    if (checks != null) {
      map[WorkerHistorySchema.checks] =
          checks?.map((e) => e?.toJson())?.toList();
    }
    return map;
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

  static ExperienceVerificationStatus verificationStatusFromString(
      String type) {
    ExperienceVerificationStatus verificationStatus =
        ExperienceVerificationStatus.Unchecked;
    if (type == WorkerHistorySchema.unchecked) {
      verificationStatus = ExperienceVerificationStatus.Unchecked;
    } else if (type == WorkerHistorySchema.checked) {
      verificationStatus = ExperienceVerificationStatus.Checked;
    } else if (type == WorkerHistorySchema.awaitingVerification) {
      verificationStatus = ExperienceVerificationStatus.AwaitingVerification;
    } else if (type == WorkerHistorySchema.verified) {
      verificationStatus = ExperienceVerificationStatus.Verified;
    } else if (type == WorkerHistorySchema.rejected) {
      verificationStatus = ExperienceVerificationStatus.Rejected;
    }
    return verificationStatus;
  }

  static String stringFromVerificationStatus(
      ExperienceVerificationStatus verificationStatus) {
    String status = WorkerHistorySchema.unchecked;
    if (verificationStatus == ExperienceVerificationStatus.Unchecked) {
      status = WorkerHistorySchema.unchecked;
    } else if (verificationStatus == ExperienceVerificationStatus.Checked) {
      status = WorkerHistorySchema.checked;
    } else if (verificationStatus ==
        ExperienceVerificationStatus.AwaitingVerification) {
      status = WorkerHistorySchema.awaitingVerification;
    } else if (verificationStatus == ExperienceVerificationStatus.Verified) {
      status = WorkerHistorySchema.verified;
    } else if (verificationStatus == ExperienceVerificationStatus.Rejected) {
      status = WorkerHistorySchema.rejected;
    }
    return status;
  }
}

// class Occupation {
//   DocumentReference occupationRef;
//   String value;
//
//   Occupation({
//     this.occupationRef,
//     this.value,
//   });
//
//   factory Occupation.fromJson(Map<String, dynamic> json) {
//     if (json != null && json.isNotEmpty) {
//       DocumentReference documentReference;
//       if (json[WorkerHistorySchema.occupationRef] is String) {
//         documentReference = WorkHistory.documentReferenceFromString(
//             json[WorkerHistorySchema.occupationRef]);
//       } else {
//         documentReference = json[WorkerHistorySchema.occupationRef];
//       }
//       return Occupation(
//           occupationRef: documentReference,
//           value: json[WorkerHistorySchema.value] ?? "");
//     }
//     return null;
//   }
//
//   Map<String, dynamic> toJson() => {
//         WorkerHistorySchema.occupationRef: occupationRef?.path,
//         WorkerHistorySchema.value: value,
//       };
//
//   factory Occupation.fromModel(OccupationModel model) => Occupation(
//         occupationRef: model?.occupationRef,
//         value: model?.value,
//       );
// }

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
        WorkerHistorySchema.checkRef: checkRef?.path,
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
        WorkerHistorySchema.qualificationRef: qualificationRef?.path,
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

// class Skill {
//   DocumentReference skillRef;
//   String value;
//
//   Skill({
//     this.skillRef,
//     this.value,
//   });
//
//   factory Skill.fromJson(Map<String, dynamic> json) {
//     if (json != null && json.isNotEmpty) {
//       DocumentReference documentReference;
//       if (json[WorkerHistorySchema.skillRef] is String) {
//         documentReference = WorkHistory.documentReferenceFromString(
//             json[WorkerHistorySchema.skillRef]);
//       } else {
//         documentReference = json[WorkerHistorySchema.skillRef];
//       }
//       return Skill(
//         skillRef: documentReference,
//         value: json[WorkerHistorySchema.value],
//       );
//     }
//     return null;
//   }
//
//   factory Skill.fromModel(SkillsModel model) => Skill(
//         skillRef: FirebaseFirestore.instance
//             .collection(FbCollections.skills)
//             .doc(model?.docID),
//         value: model?.value,
//       );
//
//   Map<String, dynamic> toJson() => {
//         WorkerHistorySchema.skillRef: skillRef?.path,
//         WorkerHistorySchema.value: value,
//       };
// }

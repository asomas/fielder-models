import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/old/schema/invite_staff_schema.dart';
import 'package:fielder_models/core/enums/enums.dart';
import 'package:flutter/cupertino.dart';

class WorkerModel {
  String docID;
  String firstName;
  String lastName;
  String pictureUrl;
  bool isStaff;
  String phone;
  bool hasLoggedIn;
  CandidatesWorkerType workerType;

  WorkerModel(
      {this.docID,
      this.firstName,
      this.lastName,
      this.pictureUrl,
      this.isStaff,
      this.phone,
      this.hasLoggedIn,
      this.workerType});

  factory WorkerModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map != null && map.isNotEmpty) {
      final String _firstName = map['first_name'] ?? '';
      final String _lastName = map['last_name'] ?? '';
      final String _pictureURL = map['picture_url'] ?? '';
      final bool _isStaff = map['is_staff'] ?? false;
      final String _phone = map['phone'] ?? '';
      final bool _hasLoggedIn = map['has_logged_in'] ?? true;
      var workerModel = WorkerModel(
        docID: docID,
        firstName: _firstName,
        lastName: _lastName,
        pictureUrl: _pictureURL,
        isStaff: _isStaff,
        hasLoggedIn: _hasLoggedIn,
        phone: _phone,
      );
      return workerModel;
    }
    return null;
  }

  Map<String, dynamic> toJsonForInterviews() {
    return {
      InviteStaffSchema.workerId: docID,
      InviteStaffSchema.workerFirstName: firstName,
      InviteStaffSchema.workerLastName: lastName,
      InviteStaffSchema.workerPhone: phone,
      InviteStaffSchema.workerType:
          EnumHelpers.stringFromCandidatesWorkerType(workerType)
    };
  }

  WorkerModel fromJsonForInterviews(Map<String, dynamic> json) {
    return WorkerModel(
        docID: json[InviteStaffSchema.workerId],
        firstName: json[InviteStaffSchema.workerFirstName],
        lastName: json[InviteStaffSchema.workerLastName],
        phone: json[InviteStaffSchema.workerPhone],
        workerType: EnumHelpers.candidatesWorkerTypeFromString(
          json[InviteStaffSchema.workerType],
        ));
  }

  String getName() {
    return '${firstName ?? ''} ${lastName ?? ''}';
  }
}

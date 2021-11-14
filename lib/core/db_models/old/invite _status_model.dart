import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/old/schema/staff_status_schema.dart';
import 'package:fielder_models/core/enums/enums.dart';

class InviteStatusModel {
  bool isStaff;
  InviteStaffStatus status;
  String workerFirstName;
  String workerLastName;
  String workerPhone;
  DateTime createdAt;
  String invitationId;
  DocumentReference workerRef;
  String pictureUrl;
  bool fromOffer;
  DocumentReference shiftRef;

  InviteStatusModel(
      {this.isStaff = false,
      this.status,
      this.workerFirstName = '',
      this.workerLastName = '',
      this.workerPhone = '',
      this.createdAt,
      this.invitationId,
      this.workerRef,
      this.pictureUrl,
      this.fromOffer = false,
      this.shiftRef});

  Map<String, dynamic> toJSON() {
    //print('AddJobModel toJSON invoked');
    Map<String, dynamic> _map = {};
    try {
      // print('job created invoked');

      _map = {
        StaffStatusSchema.isStaff: isStaff,
        StaffStatusSchema.workerFirstName: workerFirstName,
        StaffStatusSchema.workerLastName: workerLastName,
        StaffStatusSchema.status: status,
      };

      print("InviteStaffModel map -> $_map");
    } catch (e) {
      print('InviteStaffModel toJSON error: $e');
    }
    return _map;
  }

  factory InviteStatusModel.fromMap(Map data, {String invitationId}) {
    return InviteStatusModel(
        invitationId: invitationId ?? "",
        isStaff: data[StaffStatusSchema.isStaff],
        status: EnumHelpers.inviteStaffStatusFromString(
            data[StaffStatusSchema.status]),
        workerFirstName: data[StaffStatusSchema.workerFirstName],
        workerLastName: data[StaffStatusSchema.workerLastName],
        workerPhone: data[StaffStatusSchema.workerPhone],
        workerRef: data[StaffStatusSchema.workerRef],
        createdAt: data[StaffStatusSchema.createdAt]?.toDate());
  }

  clear() {
    isStaff = null;
    status = InviteStaffStatus.None;
    workerFirstName = "";
    workerLastName = "";
    workerPhone = "";
  }
}

class UploadCsvModel {
  String firstName;
  String lastName;
  String phoneNumber;
  WorkerType workerType;

  UploadCsvModel(
      {this.firstName, this.lastName, this.phoneNumber, this.workerType});

  factory UploadCsvModel.fromMap(Map<String, dynamic> map) => UploadCsvModel(
        firstName: map[UploadCsvSchema.firstName],
        lastName: map[UploadCsvSchema.lastName],
        phoneNumber: map[UploadCsvSchema.phoneNumber],
        workerType: EnumHelpers.workerTypeFromString(map[UploadCsvSchema.type]),
      );
}

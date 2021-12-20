import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/old/address_model.dart';
import 'package:fielder_models/core/db_models/old/schema/interviews_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/invite_staff_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/shift_pattern_data_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/staff_status_schema.dart';
import 'package:fielder_models/core/db_models/worker/schema/locationSchema.dart';
import 'package:fielder_models/core/enums/enums.dart';

class InviteStatusModel {
  CandidatesWorkerType workerType;
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
  InterviewType interviewType;
  AddressModel addressModel;

  InviteStatusModel(
      {this.workerType,
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
        StaffStatusSchema.workerType:
            EnumHelpers.stringFromCandidatesWorkerType(workerType),
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
        workerType: EnumHelpers.candidatesWorkerTypeFromString(
            data[StaffStatusSchema.workerType]),
        status: EnumHelpers.inviteStaffStatusFromString(
            data[StaffStatusSchema.status]),
        workerFirstName: data[StaffStatusSchema.workerFirstName],
        workerLastName: data[StaffStatusSchema.workerLastName],
        workerPhone: data[StaffStatusSchema.workerPhone],
        workerRef: data[StaffStatusSchema.workerRef],
        createdAt: data[StaffStatusSchema.createdAt]?.toDate());
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> _map = {};
    try {
      _map = {
        InviteStaffSchema.workerFirstName: workerFirstName,
        InviteStaffSchema.workerLastName: workerLastName,
        InviteStaffSchema.workerPhone: workerPhone,
        InviteStaffSchema.workerType:
            EnumHelpers.stringFromCandidatesWorkerType(workerType),
        InterviewsSchema.interviewType:
            EnumHelpers.interviewTypeFromString(interviewType),
      };
      if (shiftRef != null) {
        _map[InviteStaffSchema.shiftPatternId] = shiftRef.id;
      }
      if (addressModel != null) {
        _map[ShiftDataSchema.newLocationData] = {
          ShiftDataSchema.address: addressModel.toJSON(),
          ShiftDataSchema.coords: {
            LocationSchema.lat: addressModel?.coordinates?.latitude,
            LocationSchema.lng: addressModel?.coordinates?.longitude
          }
        };
      }
      print("InviteStaffModel map -> $_map");
    } catch (e) {
      print('InviteStaffModel toJSON error: $e');
    }
    return _map;
  }

  clear() {
    workerType = null;
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

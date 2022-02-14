import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/old/address_model.dart';
import 'package:fielder_models/core/db_models/old/checks_model.dart';
import 'package:fielder_models/core/db_models/old/interview_model.dart';
import 'package:fielder_models/core/db_models/old/offers_model.dart';
import 'package:fielder_models/core/db_models/old/schema/interviews_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/invite_staff_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/job_summary_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/organisation_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/shift_pattern_data_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/staff_status_schema.dart';
import 'package:fielder_models/core/db_models/worker/schema/locationSchema.dart';
import 'package:fielder_models/core/enums/enums.dart';
import 'package:flutter/material.dart';

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
  String shiftId;
  String workerId;
  bool requireInterview;
  DocumentReference organisationRef;
  DocumentReference organisationUserRef;
  String summaryInformation;
  DateTime createdDate;
  Color brandColor;
  String brandLogo;
  String brandBanner;
  String organisationName;
  DocumentReference interviewRef;
  InterviewModel interviewModel;
  List<CheckModel> checkModels;
  Offers offer;

  InviteStatusModel({
    this.workerType,
    this.status,
    this.workerFirstName = '',
    this.workerLastName = '',
    this.workerPhone = '',
    this.createdAt,
    this.invitationId,
    this.workerRef,
    this.pictureUrl,
    this.fromOffer = false,
    this.shiftRef,
    this.shiftId,
    this.addressModel,
    this.interviewType,
    this.workerId,
    this.requireInterview,
    this.organisationUserRef,
    this.organisationRef,
    this.organisationName,
    this.brandColor,
    this.createdDate,
    this.brandBanner,
    this.brandLogo,
    this.summaryInformation,
    this.interviewRef,
    this.interviewModel,
    this.checkModels,
    this.offer,
  });

  static const Color blue = Color(0xFF0288D1);

  static Color hexToColor(String code) {
    if (code?.isNotEmpty == true) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }
    return blue;
  }

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
    InterviewType _interview = InterviewType.NoInterview;
    DocumentReference _interviewRef;
    InterviewModel _interviewModel;
    AddressModel _addressModel;
    List<CheckModel> _checks = [];
    if (data.containsKey(InviteStaffSchema.interview) &&
        data[InviteStaffSchema.interview] != null) {
      _interview = EnumHelpers.getInterviewType(
          data[InviteStaffSchema.interview][InterviewsSchema.interviewType]);
      _interviewRef =
          data[InviteStaffSchema.interview][InviteStaffSchema.interviewSlotRef];
      _interviewModel = InterviewModel.fromMap(
          _interviewRef?.id,
          data[InviteStaffSchema.interview]
              [InviteStaffSchema.interviewSlotData]);
    }
    if (data.containsKey(InviteStaffSchema.address) &&
        data[InviteStaffSchema.address] != null) {
      _addressModel =
          AddressModel.fromInvitationsMap(map: data[InviteStaffSchema.address]);
    }
    if (data.containsKey(InviteStaffSchema.checks) &&
        data[InviteStaffSchema.checks] != null) {
      _checks = (data[InviteStaffSchema.checks] as List)
          .map((e) => CheckModel.fromMap(
              map: e, checkID: e[JobSummarySchema.checkRef]?.id))
          .toList();
    }
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
      workerId: (data[StaffStatusSchema.workerRef] as DocumentReference)?.id,
      shiftRef: data[StaffStatusSchema.shiftPatternRef],
      createdAt: data[StaffStatusSchema.createdAt]?.toDate(),
      requireInterview: data[InviteStaffSchema.requiresInterview] ?? false,
      organisationRef: data[InviteStaffSchema.organisationRef],
      organisationUserRef: data[InviteStaffSchema.organisationUserRef],
      summaryInformation: data[InviteStaffSchema.summaryInformation] ?? "",
      createdDate: data[InviteStaffSchema.createdAt]?.toDate(),
      organisationName: data[OrganisationSchema.organisationData] != null
          ? data[OrganisationSchema.organisationData]
              [OrganisationSchema.organisationName]
          : "",
      brandBanner: data.containsKey(OrganisationSchema.organisationData)
          ? data[OrganisationSchema.organisationData]
              [OrganisationSchema.brandBanner]
          : "",
      brandLogo: data.containsKey(OrganisationSchema.organisationData)
          ? data[OrganisationSchema.organisationData]
              [OrganisationSchema.brandLogo]
          : "",
      brandColor: data.containsKey(OrganisationSchema.organisationData)
          ? hexToColor(data[OrganisationSchema.organisationData]
              [OrganisationSchema.brandColor])
          : blue,
      interviewType: _interview,
      interviewRef: _interviewRef,
      interviewModel: _interviewModel,
      addressModel: _addressModel,
      checkModels: _checks,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> _map = {};
    try {
      _map = {
        InviteStaffSchema.workerFirstName: workerFirstName,
        InviteStaffSchema.workerLastName: workerLastName,
        InviteStaffSchema.workerType:
            EnumHelpers.stringFromCandidatesWorkerType(workerType),
        InterviewsSchema.interviewType:
            EnumHelpers.interviewTypeFromString(interviewType),
      };
      if (workerId != null && workerId.isNotEmpty) {
        _map[InviteStaffSchema.workerId] = workerId;
      }
      if (workerPhone != null && workerPhone.isNotEmpty) {
        _map[InviteStaffSchema.workerPhone] = workerPhone;
      }
      if (shiftId != null && shiftId.isNotEmpty) {
        _map[InviteStaffSchema.shiftPatternId] = shiftId;
      } else if (shiftRef != null) {
        _map[InviteStaffSchema.shiftPatternId] = shiftRef.id;
      }
      if (checkModels != null && checkModels.isNotEmpty) {
        _map[InviteStaffSchema.checkIds] =
            checkModels.map((e) => e?.checkID).toList();
      }
      if (addressModel != null) {
        _map[ShiftDataSchema.address] = {
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

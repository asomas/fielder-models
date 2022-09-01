import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/helpers/helpers.dart';
import 'package:fielder_models/core/db_models/old/address_model.dart';
import 'package:fielder_models/core/db_models/old/schema/interviews_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/shift_pattern_data_schema.dart';
import 'package:fielder_models/core/db_models/worker/schema/locationSchema.dart';
import 'package:fielder_models/core/enums/enums.dart';
import 'package:flutter/material.dart';

class InterviewModel {
  int interviewDuration;
  int breakDuration;
  int repeatCount;
  InterviewType interviewType;
  AddressModel addressModel;
  String organisationId;
  DateTime interviewStartDateTime;
  DateTime interviewEndDateTime;
  bool assigned;
  DocumentReference organisationRef;
  DocumentReference organisationUserRef;
  String interviewSlotId;

  CandidatesWorkerType workerType;
  String workerFirstName;
  String workerLastName;
  String workerPhone;
  String workerId;
  String invitationId;
  OfferStatus invitationStatus;

  InterviewModel({
    @required this.interviewDuration,
    @required this.breakDuration,
    @required this.repeatCount,
    @required this.interviewType,
    @required this.organisationId,
    @required this.interviewStartDateTime,
    this.addressModel,
    this.assigned = false,
    this.organisationRef,
    this.organisationUserRef,
    this.interviewEndDateTime,
    this.interviewSlotId,
    this.workerId,
    this.workerFirstName,
    this.workerLastName,
    this.workerPhone,
    this.workerType,
    this.invitationId,
    this.invitationStatus,
  });

  factory InterviewModel.fromMap(
      String interviewDocId, Map<String, dynamic> map) {
    if (map != null && map.isNotEmpty) {
      try {
        InterviewType _interview =
            EnumHelpers.getInterviewType(map[InterviewsSchema.interviewType]);
        DateTime _startTime = Helpers.convertToLocalTime(
            (map[InterviewsSchema.startTime] as Timestamp)?.toDate());
        DateTime _endTime = Helpers.convertToLocalTime(
            (map[InterviewsSchema.endTime] as Timestamp)?.toDate());
        int duration;
        if (_startTime != null && _endTime != null) {
          duration = _endTime.difference(_startTime).inMinutes;
        }
        return InterviewModel(
          interviewDuration: duration,
          breakDuration: 0,
          repeatCount: 0,
          interviewType: _interview,
          organisationId:
              (map[InterviewsSchema.organisationRef] as DocumentReference)?.id,
          interviewStartDateTime: _startTime,
          interviewEndDateTime: _endTime,
          organisationUserRef: map[InterviewsSchema.organisationUserRef],
          assigned: map[InterviewsSchema.assigned],
          interviewSlotId: interviewDocId,
        );
      } catch (e, s) {
        print("interview model to map catch___${e}____$s");
        return null;
      }
    } else {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    try {
      Map<String, dynamic> jsonMap = {};
      jsonMap = {
        InterviewsSchema.duration: interviewDuration,
        InterviewsSchema.breakDuration: breakDuration,
        InterviewsSchema.interviewType:
            EnumHelpers.interviewTypeFromString(interviewType),
        InterviewsSchema.organisationId: organisationId,
        InterviewsSchema.repeatCount: repeatCount,
        InterviewsSchema.startTime: interviewStartDateTime?.toString()
      };
      if (addressModel != null) {
        jsonMap[ShiftDataSchema.newLocationData] = {
          ShiftDataSchema.address: addressModel.toJSON(),
          ShiftDataSchema.coords: {
            LocationSchema.lat: addressModel?.coordinates?.latitude,
            LocationSchema.lng: addressModel?.coordinates?.longitude
          }
        };
      }
      return jsonMap;
    } catch (e, s) {
      print("interview model to json catch___${e}____$s");
      return null;
    }
  }

  @override
  bool operator ==(other) {
    return "${this.interviewSlotId}" == "${other.interviewSlotId}";
  }
}

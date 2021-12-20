import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
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

  InterviewModel({
    @required this.interviewDuration,
    @required this.breakDuration,
    @required this.repeatCount,
    @required this.interviewType,
    @required this.organisationId,
    @required this.interviewStartDateTime,
    this.addressModel,
  });

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
        InterviewsSchema.startTime: interviewStartDateTime
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
}

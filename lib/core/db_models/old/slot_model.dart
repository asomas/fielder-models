import 'package:fielder_models/core/db_models/old/interview_model.dart';
import 'package:fielder_models/core/db_models/old/shift_activities_model.dart';
import 'package:fielder_models/core/db_models/old/shift_pattern_data_model.dart';
import 'package:fielder_models/core/enums/slot_status_enums.dart';
import 'package:flutter/material.dart';

class SlotModel {
  final String shiftId;
  final DateTime startAt;
  final DateTime endAt;
  final String slotText;
  String workerAvatarUrl;
  final String workerId;
  final String workerName;
  final DateTime weekDay;
  final SlotStatusIcon slotStatusIcon;
  final ShiftPatternDataModel shiftPatternDataModel;
  final ShiftActivitiesModel shiftActivitiesModel;
  final bool isUnavailable;
  final bool spanMultipleDays;
  final bool isHead;
  final bool isTail;
  final InterviewModel interviewModel;
  final Color slotColor;
  int timeRowIndex;
  bool allDay;
  //List<String> resourceIds;

  SlotModel({
    this.shiftId,
    this.slotText = '',
    this.workerAvatarUrl,
    this.startAt,
    this.endAt,
    this.workerId,
    this.workerName = '',
    this.weekDay,
    this.shiftPatternDataModel,
    this.shiftActivitiesModel,
    this.slotStatusIcon = SlotStatusIcon.Inactive,
    this.isUnavailable = false,
    this.spanMultipleDays = false,
    this.isHead = false,
    this.isTail = false,
    this.interviewModel,
    this.timeRowIndex = 1,
    @required this.slotColor,
    this.allDay = false,
    //this.resourceIds,
  });

  @override
  bool operator ==(other) {
    if (interviewModel != null) {
      return this.interviewModel.interviewSlotId ==
          other.interviewModel.interviewSlotId;
    }
    return "${this.shiftId}" == "${other.shiftId}" &&
        this.isHead == other.isHead &&
        this.isTail == other.isTail;
  }

  @override
  int get hashCode => super.hashCode;
}

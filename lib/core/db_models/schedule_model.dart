import 'package:flutter/material.dart';
import 'package:fielder_models/core/db_models/worker_assignment_model.dart';
import 'package:fielder_models/core/db_models/workers_model.dart';

class ScheduleModel{
  final WorkerModel worker;
  final List<WorkerAssignmentModel> assignmentsArray;


  ScheduleModel({
    @required this.worker,
    @required this.assignmentsArray,
});
}

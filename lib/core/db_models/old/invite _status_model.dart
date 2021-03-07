import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/schema/staff_status_schema.dart';
import 'package:fielder_models/core/db_models/old/additional_info_model.dart';
import 'package:fielder_models/core/db_models/old/job_template_model.dart';
import 'package:fielder_models/core/db_models/old/qualification_model.dart';
import 'package:fielder_models/core/db_models/old/schema/job_template_schema.dart';
import 'package:fielder_models/core/db_models/old/shift_data_model.dart';
import 'package:fielder_models/core/db_models/old/skills_model.dart';
import 'default_location_data_model.dart';

class InviteStatusModel {
  bool isStaff;
  String status;
  String workerFirstName;
  String workerLastName;
  String workerPhone;
  DateTime createdAt;

  InviteStatusModel({
    this.isStaff = null,
    this.status = '',
    this.workerFirstName = '',
    this.workerLastName = '',
    this.workerPhone = '',
    this.createdAt,
  });

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

  factory InviteStatusModel.fromMap(Map data) {
    return InviteStatusModel(
        isStaff: data[StaffStatusSchema.isStaff],
        status: data[StaffStatusSchema.status],
        workerFirstName: data[StaffStatusSchema.workerFirstName],
        workerLastName: data[StaffStatusSchema.workerLastName],
        workerPhone: data[StaffStatusSchema.workerPhone],
        createdAt: data[StaffStatusSchema.createdAt]?.toDate()
    );
  }

  clear() {
    isStaff = null;
    status = "";
    workerFirstName = "";
    workerLastName = "";
    workerPhone = "";
  }

}
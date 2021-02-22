import 'package:fielder_models/core/db_models/schema/staff_status_schema.dart';
import 'package:fielder_models/core/db_models/additional_info_model.dart';
import 'package:fielder_models/core/db_models/job_template_model.dart';
import 'package:fielder_models/core/db_models/qualification_model.dart';
import 'package:fielder_models/core/db_models/schema/job_template_schema.dart';
import 'package:fielder_models/core/db_models/shift_data_model.dart';
import 'package:fielder_models/core/db_models/skills_model.dart';
import 'default_location_data_model.dart';

class InviteStatusModel {
  bool isStaff;
  String status;
  String workerFirstName;
  String workerLastName;
  String workerPhone;

  InviteStatusModel({
    this.isStaff = null,
    this.status = '',
    this.workerFirstName = '',
    this.workerLastName = '',
    this.workerPhone = ''
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
        workerPhone: data[StaffStatusSchema.workerPhone]
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
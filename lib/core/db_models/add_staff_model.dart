import 'package:fielder_models/core/db_models/schema/invite_staff_schema.dart';

class AddStaffModel {
  String worker_first_name;
  String worker_last_name;
  String worker_phone;
  String is_staff;
  String workerRef;
  String status;

  AddStaffModel({
    this.worker_first_name = "",
    this.worker_last_name = "",
    this.worker_phone = "",
    this.is_staff = "",
  });

  Map<String, dynamic> toJSON() {
    print("AdStaffModel to Json invoked");
    Map<String, dynamic> _map = {};
    try {
      print("staff created invoked");

      _map = {
        InviteStaffSchema.workerFirstName: worker_first_name,
        InviteStaffSchema.workerLastName: worker_last_name,
        InviteStaffSchema.workerPhone: worker_phone,
        InviteStaffSchema.isStaff: is_staff,
      };

      print("addstaffmodel map -> $_map");
    } catch(e) {
      print('AddStaffModel toJSON error: $e');
    }
    return _map;
  }

  clear() {
    worker_first_name = '';
    worker_last_name = '';
    worker_phone = '';
    is_staff = '';
  }
}
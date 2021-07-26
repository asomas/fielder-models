import 'package:fielder_models/core/db_models/old/schema/invite_staff_schema.dart';

class AddStaffModel {
  String workerFirstName;
  String workerLastName;
  String workerPhone;
  String isStaff;
  String workerRef;
  String status;

  AddStaffModel({
    this.workerFirstName = "",
    this.workerLastName = "",
    this.workerPhone = "",
    this.isStaff = "",
  });

  Map<String, dynamic> toJSON() {
    print("AdStaffModel to Json invoked");
    Map<String, dynamic> _map = {};
    try {
      print("staff created invoked");

      _map = {
        InviteStaffSchema.workerFirstName: workerFirstName,
        InviteStaffSchema.workerLastName: workerLastName,
        InviteStaffSchema.workerPhone: workerPhone,
        InviteStaffSchema.isStaff: isStaff,
      };

      print("addstaffmodel map -> $_map");
    } catch (e) {
      print('AddStaffModel toJSON error: $e');
    }
    return _map;
  }

  clear() {
    workerFirstName = '';
    workerLastName = '';
    workerPhone = '';
    isStaff = '';
  }
}

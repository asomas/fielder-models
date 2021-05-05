class AssignWorkerModel {
  final List<StaffModel> staffList;
  final List<FielderModel> fielderList;

  AssignWorkerModel({this.staffList, this.fielderList});

  factory AssignWorkerModel.fromMap(Map<String, dynamic> map) {
    return AssignWorkerModel(
      staffList: _getStaffList(map["staff"]["hits"]),
      fielderList: _getFieldersList(map["fielders"]["hits"]),
    );
  }

  static List<StaffModel> _getStaffList(List hits) {
    List<StaffModel> list = [];
    hits.forEach((element) {
      list = (hits).map((model) => StaffModel.fromMap(model)).toList();
    });
    return list;
  }

  static List<FielderModel> _getFieldersList(List hits) {
    List<FielderModel> list = [];
    hits.forEach((element) {
      list = (hits).map((model) => FielderModel.fromMap(model)).toList();
    });
    return list;
  }
}

class StaffModel {
  String workerId;
  String firstName;
  String lastName;
  String pictureUrl;
  bool isStaff;

  StaffModel(
      {this.workerId,
      this.isStaff,
      this.firstName,
      this.lastName,
      this.pictureUrl});

  factory StaffModel.fromMap(Map<String, dynamic> map) {
    return StaffModel(
        workerId: map["worker_id"],
        isStaff: map["is_staff"],
        firstName: map["first_name"],
        lastName: map["last_name"],
        pictureUrl: map["picture_url"]);
  }
}

class FielderModel {
  String workerId;
  bool isStaff;
  String firstName;
  String lastName;
  String pictureUrl;

  FielderModel(
      {this.workerId,
      this.isStaff,
      this.firstName,
      this.lastName,
      this.pictureUrl});

  factory FielderModel.fromMap(Map<String, dynamic> map) {
    return FielderModel(
        workerId: map["worker_id"],
        isStaff: map["is_staff"],
        firstName: map["first_name"],
        lastName: map["last_name"],
        pictureUrl: map["picture_url"]);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/job_shift_data_model.dart';
import 'package:fielder_models/core/db_models/worker_log_model.dart';

class WorkerAssignmentModel {
  final String docID;
  final DateTime endDate;
  JobShiftDataModel jobShift;
  WorkerLogModel log;
  final DateTime startDate;
  final String workerID;

  WorkerAssignmentModel({
    this.docID,
    this.workerID,
    this.startDate,
    this.endDate,
    this.jobShift,
    this.log,
  }) : assert(
          docID != null && endDate != null && jobShift != null && startDate != null && workerID != null,
        );

  factory WorkerAssignmentModel.fromMap({
    @required String docID,
    @required String jobShiftID,
    @required Map<String, dynamic> map,
    @required String workerID,
  }) {
    if (map.isNotEmpty) {
      try {
        final Timestamp _startTimeStamp = map['start_date'];
        DateTime _startDate;
        if (_startTimeStamp != null) {
          _startDate = DateTime.fromMillisecondsSinceEpoch(
            _startTimeStamp.millisecondsSinceEpoch,
          );
        }
        final Timestamp _endTimeStamp = map['end_date'];
        DateTime _endDate;
        if (_endTimeStamp != null) {
          _endDate = DateTime.fromMillisecondsSinceEpoch(
            _endTimeStamp.millisecondsSinceEpoch,
          );
        }
        final JobShiftDataModel _jobShiftData = JobShiftDataModel.fromMap(
          docID: jobShiftID,
          map: map['job_shift_data'] ?? {},
        );

        WorkerLogModel _workerLog;
        final DocumentReference logRefDr = map['worker_log_ref'];

        if (logRefDr != null) {
          _workerLog = WorkerLogModel.fromMap(
            docID: logRefDr.id,
            map: map['worker_log_data'] ?? {},
          );
        }

        return WorkerAssignmentModel(
          docID: docID,
          workerID: workerID,
          startDate: _startDate,
          endDate: _endDate,
          jobShift: _jobShiftData,
          log: _workerLog,
        );
      } catch (e) {
        print('WorkerAssignmentModel.fromMap error: $e');
      }
    }
    return null;
  }
}

class WorkerLogModel {
  String docID;
  DateTime clockInTime;
  GeoPoint clockInLocation;
  DateTime clockOutTime;
  GeoPoint clockOutLocation;
  String workerID;

  WorkerLogModel({
    this.clockInTime,
    this.clockInLocation,
    this.clockOutTime,
    this.clockOutLocation,
    this.docID,
    this.workerID,
  });

  // : assert(
  //     clockInTime != null &&
  //         clockInLocation != null &&
  //         docID != null &&
  //         workerID != null,
  //   );

  factory WorkerLogModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map?.isNotEmpty == true) {
      try {
        final GeoPoint _clockInLocation = map['clock_in_location'];
        final GeoPoint _clockOutLocation = map['clock_out_location'];
        //final DocumentReference _workerRef = map['worker_ref'];
        final Timestamp _clockInTimeStamp = map['clock_in_time'];
        DateTime _clockInDateTime;
        if (_clockInTimeStamp != null) {
          _clockInDateTime = DateTime.fromMillisecondsSinceEpoch(
            _clockInTimeStamp.millisecondsSinceEpoch,
          );
        }
        final Timestamp _clockOutTimeStamp = map['clock_out_time'];
        DateTime _clockOutDateTime;
        if (_clockOutTimeStamp != null) {
          _clockOutDateTime = DateTime.fromMillisecondsSinceEpoch(
            _clockOutTimeStamp.millisecondsSinceEpoch,
          );
        }
        return WorkerLogModel(
          docID: docID,
          clockInTime: _clockInDateTime,
          clockInLocation: _clockInLocation,
          clockOutTime: _clockOutDateTime,
          clockOutLocation: _clockOutLocation,
          //workerID: _workerRef.id,
        );
      } on Exception catch (e) {
        print("WorkerLogModel.fromMap error $e");
      }
    }
    return null;
  }
}

class WorkerTrackedTimeModel {
  String docID;
  DateTime clockInTime;
  GeoPoint clockInLocation;
  DateTime clockOutTime;
  GeoPoint clockOutLocation;

  WorkerTrackedTimeModel({
    this.clockInTime,
    this.clockInLocation,
    this.clockOutTime,
    this.clockOutLocation,
    this.docID,
  }) : assert(
          clockInTime != null && clockInLocation != null && docID != null,
        );

  factory WorkerTrackedTimeModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      try {
        final GeoPoint _clockInLocation = map['clock_in_location'];
        final GeoPoint _clockOutLocation = map['clock_out_location'];
        final Timestamp _clockInTimeStamp = map['clock_in_time'];
        DateTime _clockInDateTime;
        if (_clockInTimeStamp != null) {
          _clockInDateTime = DateTime.fromMillisecondsSinceEpoch(
            _clockInTimeStamp.millisecondsSinceEpoch,
          );
        }
        final Timestamp _clockOutTimeStamp = map['clock_out_time'];
        DateTime _clockOutDateTime;
        if (_clockOutTimeStamp != null) {
          _clockOutDateTime = DateTime.fromMillisecondsSinceEpoch(
            _clockOutTimeStamp.millisecondsSinceEpoch,
          );
        }

        return WorkerTrackedTimeModel(
          docID: docID,
          clockInTime: _clockInDateTime,
          clockInLocation: _clockInLocation,
          clockOutTime: _clockOutDateTime,
          clockOutLocation: _clockOutLocation,
        );
      } on Exception catch (e) {
        print("WorkerTrackedTimeModel.fromMap error $e");
      }
    }
    return null;
  }
}

class Workers {
  String docID;
  DateTime createdAt;
  String fullTimeEmployerId;
  bool isCompleted;
  String firstName;
  String lastName;
  String phone;
  String pictureUrl;
  String uId;
  DateTime updatedAt;

  Workers(
      {this.docID,
      this.createdAt,
      this.fullTimeEmployerId,
      this.isCompleted,
      this.firstName,
      this.lastName,
      this.pictureUrl,
      this.phone,
      this.updatedAt,
      this.uId});

  factory Workers.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      final Timestamp _createdAtTimeStamp = map['created_at'];
      DateTime _createdAtDateTime;
      if (_createdAtTimeStamp != null) {
        _createdAtDateTime = DateTime.fromMillisecondsSinceEpoch(
          _createdAtTimeStamp.millisecondsSinceEpoch,
        );
      }

      final Timestamp _updatedAtTimeStamp = map['updated_at'];
      DateTime _updatedAtDateTime;
      if (_updatedAtTimeStamp != null) {
        _updatedAtDateTime = DateTime.fromMillisecondsSinceEpoch(
          _updatedAtTimeStamp.millisecondsSinceEpoch,
        );
      }

      final DocumentReference _fullTimeEmployerIdRef = map['full_time_employer_ref'];
      final bool _isCompleted = map['is_completed'] ?? false;
      final String _phone = map['phone'] ?? '';
      final String _uID = map['uid'] ?? '';
      final String _firstName = map['first_name'] ?? '';
      final String _lastName = map['last_name'] ?? '';
      final String _pictureURL = map['picture_url'] ?? '';
      return Workers(
        docID: docID,
        createdAt: _createdAtDateTime,
        uId: _uID,
        fullTimeEmployerId: _fullTimeEmployerIdRef.id,
        phone: _phone,
        isCompleted: _isCompleted,
        updatedAt: _updatedAtDateTime,
        firstName: _firstName,
        lastName: _lastName,
        pictureUrl: _pictureURL,
      );
    }
    return null;
  }

  String getName() {
    return '${firstName ?? ''} ${lastName ?? ''}';
  }
}

class WorkerModel {
  String docID;
  String firstName;
  String lastName;
  String pictureUrl;

  WorkerModel({
    this.docID,
    this.firstName,
    this.lastName,
    this.pictureUrl,
  });

  factory WorkerModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      final String _firstName = map['first_name'] ?? '';
      final String _lastName = map['last_name'] ?? '';
      final String _pictureURL = map['picture_url'] ?? '';
      return WorkerModel(
        docID: docID,
        firstName: _firstName,
        lastName: _lastName,
        pictureUrl: _pictureURL,
      );
    }
    return null;
  }

  String getName() {
    return '${firstName ?? ''} ${lastName ?? ''}';
  }
}

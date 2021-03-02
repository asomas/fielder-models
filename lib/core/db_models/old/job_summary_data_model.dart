import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/job_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/schema/job_summary_schema.dart';
import 'package:fielder_models/core/db_models/old/workers_model.dart';

class JobSummaryDataModel {
  String docID;
  String employerID;
  JobDataModel jobDataModel;
  String jobID;
  List<WorkerModel> workersArray;

  JobSummaryDataModel({
    this.docID,
    this.employerID,
    this.jobDataModel,
    this.jobID,
    this.workersArray,
  }) : assert(
          docID != null && jobDataModel != null && jobID != null,
        );

  factory JobSummaryDataModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      try {
        String _employerID = '';
        final DocumentReference _employerRef =
            map[JobSummarySchema.employerRef];
        if (_employerRef != null) {
          _employerID = _employerRef.id;
          String _jobID = '';
          final DocumentReference _jobRef = map[JobSummarySchema.jobRef];
          if (_jobRef != null) {
            _jobID = _jobRef.id;

            final JobDataModel _jobDataModel = JobDataModel.fromMap(
                map: map[JobSummarySchema.jobData] ?? {}, docID: _jobID
            );
            final Map<String, dynamic> workers =
                map[JobSummarySchema.workers] ?? {};
            List<WorkerModel> _allWorkerArray = [];
            workers.forEach((key, element) {
              final WorkerModel _worker = WorkerModel.fromMap(
                map: element,
                docID: key,
              );

              if (_worker != null) {
                _allWorkerArray.add(_worker);
              }
            });

            if (_jobID.isNotEmpty) {
              return JobSummaryDataModel(
                docID: docID,
                employerID: _employerID,
                jobDataModel: _jobDataModel,
                jobID: _jobID,
                workersArray: _allWorkerArray,
              );
            }
          }
        }
      } catch (e) {
        print('JobSummaryDataModel fromMap error: $e');
      }
    }
    return null;
  }
}
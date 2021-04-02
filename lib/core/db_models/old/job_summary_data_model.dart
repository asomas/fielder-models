import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/old/job_data_model.dart';
import 'package:fielder_models/core/db_models/old/schema/job_summary_schema.dart';
import 'package:fielder_models/core/db_models/old/workers_model.dart';

class JobSummaryDataModel {
  String organisationId;
  JobDataModel jobDataModel;
  String jobId;
  List<WorkerModel> workersArray;

  JobSummaryDataModel({
    this.organisationId,
    this.jobDataModel,
    this.jobId,
    this.workersArray,
  }) : assert(
          jobDataModel != null && jobId != null,
        );

  factory JobSummaryDataModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      try {
        String _organisationID = '';
        final DocumentReference _organisationRef =
            map[JobSummarySchema.organisationRef];
        if (_organisationRef != null) {
          _organisationID = _organisationRef.id;
          String _jobID = '';
          final DocumentReference _jobRef = map[JobSummarySchema.jobRef];

          _jobID = docID;

          final JobDataModel _jobDataModel =
              JobDataModel.fromMap(map: map ?? {}, docID: _jobID);
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
              organisationId: _organisationID,
              jobDataModel: _jobDataModel,
              jobId: _jobID,
              workersArray: _allWorkerArray,
            );
          }
        }
      } catch (e) {
        print('JobSummaryDataModel fromMap error: $e');
      }
    }
    return null;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/job_data_model.dart';
import 'package:fielder_models/core/db_models/old/schema/job_summary_schema.dart';
import 'package:fielder_models/core/db_models/old/workers_model.dart';
import 'package:flutter/cupertino.dart';

class JobSummaryDataModel {
  String organisationId;
  JobDataModel jobDataModel;
  String jobId;
  List<WorkerModel> workersArray;
  bool isArchived;
  String jobFilterType;

  JobSummaryDataModel({
    this.organisationId,
    this.jobDataModel,
    this.jobId,
    this.workersArray,
    this.isArchived = false,
    this.jobFilterType,
  }) : assert(
          jobDataModel != null && jobId != null,
        );

  factory JobSummaryDataModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docId,
    String jobType,
  }) {
    if (map.isNotEmpty) {
      try {
        String _organisationId = '';
        final DocumentReference _organisationRef =
            map[JobSummarySchema.organisationRef];
        if (_organisationRef != null) {
          _organisationId = _organisationRef.id;
          String _jobId = '';
          _jobId = docId;

          final JobDataModel _jobDataModel =
              JobDataModel.fromMap(map: map ?? {}, docID: _jobId);
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

          if (_jobId.isNotEmpty) {
            return JobSummaryDataModel(
              organisationId: _organisationId,
              jobDataModel: _jobDataModel,
              jobId: _jobId,
              workersArray: _allWorkerArray,
              isArchived: map[JobSummarySchema.isArchived] ?? false,
              jobFilterType: jobType,
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

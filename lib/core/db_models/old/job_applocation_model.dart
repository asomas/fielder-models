import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/job_data_model.dart';
import 'package:fielder_models/core/db_models/old/schema/job_application_schema.dart';
import 'package:fielder_models/core/db_models/worker/locationModel.dart';

class JobApplicationModel {
  String docId;
  DateTime createdAt;
  DateTime updatedAt;
  DocumentReference workerRef;
  DocumentReference hiringReqRef;
  DocumentReference jobRef;
  JobDataModel jobDataModel;
  LocationModelDetail locationModel;

  JobApplicationModel(
      {this.docId,
      this.createdAt,
      this.updatedAt,
      this.workerRef,
      this.hiringReqRef,
      this.jobRef,
      this.jobDataModel,
      this.locationModel});

  factory JobApplicationModel.fromMap(String docId, Map map) {
    try {
      return JobApplicationModel(
        docId: docId,
        createdAt: (map[JobApplicationSchema.createdAt] as Timestamp)?.toDate(),
        updatedAt: (map[JobApplicationSchema.updatedAt] as Timestamp)?.toDate(),
        workerRef: map[JobApplicationSchema.workerRef],
        hiringReqRef: map[JobApplicationSchema.hiringRequestRef],
        jobRef: map[JobApplicationSchema.jobRef],
        jobDataModel: map[JobApplicationSchema.jobData] != null
            ? JobDataModel.fromMap(
                map: map[JobApplicationSchema.jobData],
                docID:
                    (map[JobApplicationSchema.jobRef] as DocumentReference)?.id,
              )
            : null,
        locationModel: map[JobApplicationSchema.locationData] != null
            ? LocationModelDetail.fromJson(
                map[JobApplicationSchema.locationData],
              )
            : null,
      );
    } catch (e, s) {
      print('job application card model catch____${e}_____$s');
      return null;
    }
  }
}

import 'package:fielder_models/core/db_models/old/schema/job_serach_schema.dart';
import 'package:fielder_models/core/db_models/old/schema/worker_schema.dart';
import 'package:fielder_models/core/db_models/old/workers_model.dart';

class JobSearchModel {
  String jobId;
  String jobTitle;
  String jobReferenceId;
  String organisationId;
  List<WorkerModel> workerModel;

  JobSearchModel(
      {this.jobId,
      this.jobTitle,
      this.jobReferenceId,
      this.organisationId,
      this.workerModel});

  factory JobSearchModel.fromMap(Map map) {
    try {
      List<WorkerModel> worker = (map[JobSearchSchema.workers] as Map)
          .entries
          .map((e) => WorkerModel(
              firstName: e.value[WorkerSchema.firstName],
              lastName: e.value[WorkerSchema.lastName],
              isStaff: e.value[WorkerSchema.isStaff]))
          .toList();
      return JobSearchModel(
        jobId: map[JobSearchSchema.jobId],
        jobTitle: map[JobSearchSchema.jobTitle],
        jobReferenceId: map[JobSearchSchema.jobReferenceId],
        organisationId: map[JobSearchSchema.organisationId],
        workerModel: worker,
      );
    } catch (e, s) {
      print("Job Search Model______${e}______$s");
      return null;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/schema/assign_workers_model.dart';
import 'package:fielder_models/core/db_models/old/shift_pattern_data_model.dart';
import 'package:fielder_models/core/db_models/old/workers_model.dart';

class Offers {
  ShiftPatternDataModel shiftPatternData;
  WorkerModel workerData;
  String status;
  String offerID;
  CandidatesModel candidatesModel;
  DocumentReference workerRef;

  Offers(
      {this.shiftPatternData,
      this.workerData,
      this.status,
      this.offerID,
      this.candidatesModel,
      this.workerRef});

  factory Offers.fromMap(String id, Map<String, dynamic> map,
          {CandidatesModel candidatesModel, WorkerModel workerModel}) =>
      Offers(
          shiftPatternData: ShiftPatternDataModel.fromMap(
              map: map["shift_pattern_data"],
              docID: map["shift_pattern_ref"]?.id),
          workerData: map.containsKey("worker_data")
              ? WorkerModel.fromMap(
                  map: map["worker_data"], docID: map["worker_ref"]?.id)
              : workerModel,
          status: map["status"],
          offerID: id,
          candidatesModel: candidatesModel,
          workerRef: map["worker_ref"]);
}

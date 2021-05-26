import 'package:fielder_models/core/db_models/old/schema/assign_workers_model.dart';
import 'package:fielder_models/core/db_models/old/shift_pattern_data_model.dart';
import 'package:fielder_models/core/db_models/old/workers_model.dart';

class Offers {
  ShiftPatternDataModel shiftPatternData;
  WorkerModel workerData;
  String status;
  String offerID;
  CandidatesModel candidatesModel;

  Offers({this.shiftPatternData, this.workerData,
    this.status, this.offerID, this.candidatesModel});

  factory Offers.fromMap(String id, Map<String, dynamic> map,
      {CandidatesModel candidatesModel}) => Offers(
        shiftPatternData: ShiftPatternDataModel.fromMap(
            map: map["shift_pattern_data"],
            docID: map["shift_pattern_ref"]?.id),
        workerData: WorkerModel.fromMap(
            map: map["worker_data"], docID: map["worker_ref"]?.id),
        status: map["status"],
        offerID: id,
        candidatesModel: candidatesModel
      );
}

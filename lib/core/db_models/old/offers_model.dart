import 'package:fielder_models/core/db_models/old/network_models/responses/worker_search_response.dart';
import 'package:fielder_models/core/db_models/old/pattern_data_model.dart';
import 'package:fielder_models/core/db_models/old/workers_model.dart';

class Offers{
  
  PatternDataModel shiftPatternData;
  WorkerModel workerData;
  String status;
  String offerID;
  
  Offers({this.shiftPatternData, this.workerData, this.status, this.offerID});
  
  factory Offers.fromMap(String id, Map<String, dynamic> map)=>
    Offers(
      shiftPatternData: PatternDataModel.fromMap(map["shift_pattern_id"], map),
      workerData: WorkerModel.fromMap(map: map["worker_data"], docID: map["worker_ref"].id),
      status: map["status"],
      offerID : id,
    );
  
}
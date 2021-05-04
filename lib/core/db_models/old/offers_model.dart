import 'package:fielder_models/core/db_models/old/job_data_model.dart';
import 'package:fielder_models/core/db_models/old/job_summary_data_model.dart';
import 'package:fielder_models/core/db_models/old/network_models/responses/worker_search_response.dart';
import 'package:fielder_models/core/db_models/old/pattern_data_model.dart';
import 'package:fielder_models/core/db_models/old/shift_pattern_data_model.dart';
import 'package:fielder_models/core/db_models/old/workers_model.dart';

class Offers{
  
  ShiftPatternDataModel shiftPatternData;
  WorkerModel workerData;
  String status;
  String offerID;
  
  Offers({this.shiftPatternData, this.workerData, this.status, this.offerID});
  
  factory Offers.fromMap(String id, Map<String, dynamic> map)=>
    Offers(
      shiftPatternData: ShiftPatternDataModel.fromMap(map: map["shift_pattern_data"], docID: map["shift_pattern_ref"]?.id),
      workerData: WorkerModel.fromMap(map: map["worker_data"], docID: map["worker_ref"]?.id),
      status: map["status"],
      offerID : id,
    );
  
}
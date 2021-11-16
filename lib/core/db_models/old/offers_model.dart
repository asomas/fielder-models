import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/old/invite%20_status_model.dart';
import 'package:fielder_models/core/db_models/old/schema/assign_workers_model.dart';
import 'package:fielder_models/core/db_models/old/shift_pattern_data_model.dart';
import 'package:fielder_models/core/db_models/old/workers_model.dart';
import 'package:fielder_models/core/enums/enums.dart';

class Offers {
  ShiftPatternDataModel shiftPatternData;
  WorkerModel workerData;
  String status;
  String offerID;
  CandidatesModel candidatesModel;
  DocumentReference workerRef;
  CandidatesWorkerType workerType;
  DocumentReference shiftPatternRef;
  DateTime updatedAt;

  Offers(
      {this.shiftPatternData,
      this.workerData,
      this.status,
      this.offerID,
      this.candidatesModel,
      this.workerRef,
      this.updatedAt,
      this.workerType,
      this.shiftPatternRef});

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
        workerRef: map["worker_ref"],
        updatedAt: map["updated_at"] != null
            ? (map["updated_at"] as Timestamp).toDate()
            : null,
        workerType:
            EnumHelpers.candidatesWorkerTypeFromString(map['worker_type']),
        shiftPatternRef: map['shift_pattern_ref'],
      );

  InviteStatusModel parseOffersToInviteStatusModel(Offers offer) {
    return InviteStatusModel(
        workerType: offer?.workerType,
        status: EnumHelpers.offerStatusToInviteStatus(
            EnumHelpers.getOfferStatusFromString(offer?.status)),
        workerFirstName: offer?.workerData?.firstName,
        workerLastName: offer?.workerData?.lastName,
        workerPhone: offer?.workerData?.phone,
        workerRef: offer?.workerRef,
        invitationId: offer?.offerID,
        createdAt: offer?.updatedAt,
        shiftRef: shiftPatternRef,
        fromOffer: true);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/old/budget_model.dart';
import 'package:fielder_models/core/db_models/old/invite%20_status_model.dart';
import 'package:fielder_models/core/db_models/old/job_data_model.dart';
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
  BudgetModel budgetModel;
  JobDataModel jobDataModel;
  DateTime sentTime;

  Offers({
    this.shiftPatternData,
    this.workerData,
    this.status,
    this.offerID,
    this.candidatesModel,
    this.workerRef,
    this.updatedAt,
    this.workerType,
    this.shiftPatternRef,
    this.budgetModel,
    this.jobDataModel,
    this.sentTime,
  });

  static bool isPending(status) {
    return status == OfferStatus.PendingWorkerFinalConfirmation ||
        status == OfferStatus.PendingWorkerResponse ||
        status == OfferStatus.PendingChecksWorker ||
        status == OfferStatus.PendingChecksBackOffice;
  }

  factory Offers.fromMap(String id, Map<String, dynamic> map,
      {CandidatesModel candidatesModel, WorkerModel workerModel}) {
    try {
      return Offers(
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
            ? (map["updated_at"] as Timestamp)?.toDate()
            : null,
        workerType:
            EnumHelpers.candidatesWorkerTypeFromString(map['worker_type']),
        shiftPatternRef: map['shift_pattern_ref'],
        budgetModel:
            map["budget"] != null ? BudgetModel.fromMap(map["budget"]) : null,
        jobDataModel: map['job_data'] != null
            ? JobDataModel.fromMap(
                map: map['job_data'],
                docID: map['job_ref']?.id,
              )
            : null,
        sentTime: (map['sent_time'] as Timestamp)?.toDate(),
      );
    } catch (e, s) {
      print('offers model catch____${e}_____$s');
      return null;
    }
  }

  InviteStatusModel parseOffersToInviteStatusModel(Offers offer) {
    return InviteStatusModel(
      workerType: offer?.workerType,
      status: EnumHelpers.getOfferStatusFromString(offer?.status),
      workerFirstName: offer?.workerData?.firstName,
      workerLastName: offer?.workerData?.lastName,
      workerPhone: offer?.workerData?.phone,
      workerRef: offer?.workerRef,
      workerId: offer?.workerRef?.id,
      invitationId: offer?.offerID,
      createdAt: offer?.updatedAt,
      shiftRef: shiftPatternRef,
      fromOffer: true,
      offer: offer,
      sentAt: sentTime,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/address_model.dart';
import 'package:fielder_models/core/db_models/old/job_data_model.dart';
import 'package:fielder_models/core/db_models/old/schema/assign_workers_model.dart';
import 'package:fielder_models/core/db_models/old/schema/hiring_request_schema.dart';
import 'package:flutter/material.dart';

class HiringRequestModel {
  final String docId;
  final DocumentReference jobRef;
  final JobDataModel jobData;
  final DocumentReference locationRef;
  final AddressModel locationData;
  final DocumentReference organisationUserRef;
  final String hiringRequestReferenceId;
  final List<CandidatesModel> matchingWorkers;
  final bool isArchived;

  HiringRequestModel({
    this.docId,
    this.jobRef,
    this.jobData,
    this.locationRef,
    this.locationData,
    this.organisationUserRef,
    this.hiringRequestReferenceId,
    this.matchingWorkers,
    this.isArchived,
  });

  factory HiringRequestModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      try {
        JobDataModel _jobData = JobDataModel.fromMap(
          map: map[HiringRequestSchema.jobData],
          docID:
              (map[HiringRequestSchema.jobRef] as DocumentReference)?.id ?? "",
        );
        AddressModel _locationData = AddressModel.fromHiringRequestMap(
            map: map[HiringRequestSchema.locationData]);
        List<CandidatesModel> _matchingWorkers = [];
        // final List _workerList =
        //     (map[HiringRequestSchema.matchingWorker])?.values?.cast<Map>();
        // (_workerList).forEach((element) {
        //   _matchingWorkers.add(CandidatesModel.forFielderNetwork(
        //     element,
        //     false,
        //     '',
        //     '',
        //     null,
        //     '',
        //     isGhostUser: null,
        //     hasLoggedIn: null,
        //   ));
        // });
        AddressModel.fromHiringRequestMap(
            map: map[HiringRequestSchema.locationData]);

        return HiringRequestModel(
          docId: docID,
          jobRef: map[HiringRequestSchema.jobRef],
          jobData: _jobData,
          locationRef: map[HiringRequestSchema.locationRef],
          locationData: _locationData,
          matchingWorkers: _matchingWorkers,
          organisationUserRef: map[HiringRequestSchema.organisationUserRef],
          hiringRequestReferenceId:
              map[HiringRequestSchema.hiringRequestReferenceId],
          isArchived: map[HiringRequestSchema.archived],
        );
      } catch (e, s) {
        print('HiringRequestModel fromMap error: ${e}______STACK: $s');
      }
    }
    return null;
  }
}

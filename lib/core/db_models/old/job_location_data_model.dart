import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/old/address_model.dart';
import 'package:fielder_models/core/db_models/schema/job_summary_schema.dart';

class JobLocationDataModel {
  String docID;
  final AddressModel address;

  JobLocationDataModel({
    this.docID,
    this.address,
  });

  factory JobLocationDataModel.fromMap({
    @required String docID,
    @required Map<String, dynamic> map,
  }) {
    if (map.isNotEmpty) {
      try {
        final Map<String, dynamic> addressMap =
            map[JobSummarySchema.address] ?? {};

        final AddressModel _address = AddressModel.fromMap(
          map: addressMap,
        );
        return JobLocationDataModel(docID: docID, address: _address);
      } catch (e) {
        print('JobLocation fromMap error: $e');
      }
    }
    return null;
  }
}

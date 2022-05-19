import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/helpers/helpers.dart';
import 'package:fielder_models/core/db_models/old/address_model.dart';
import 'package:fielder_models/core/db_models/worker/schema/locationSchema.dart';
import 'package:fielder_models/core/enums/enums.dart';

import 'schema/dbs_check_model_schema.dart';

class DBSCheckModel {
  List<HistoricalName> historicalNames;
  List<AddressHistory> addresses;
  String townOfBirth;
  String countryOfBirth;
  ChecksType checksType;
  String email;
  bool criminalRecord;
  bool trueInformationConfirmation;
  String dbsProfileNumber;

  DBSCheckModel({
    this.historicalNames,
    this.addresses,
    this.townOfBirth,
    this.countryOfBirth,
    this.checksType,
    this.email,
    this.criminalRecord,
    this.trueInformationConfirmation,
    this.dbsProfileNumber,
  });

  factory DBSCheckModel.fromMap(Map map) {
    if (map != null && map.isNotEmpty) {
      try {
        return DBSCheckModel(
          historicalNames: map[DBSCheckModelSchema.historicalNames] != null
              ? List<HistoricalName>.from(
                  map[DBSCheckModelSchema.historicalNames]
                      .map((x) => HistoricalName.fromMap(x)))
              : [],
          addresses: map[DBSCheckModelSchema.historicalAddresses] != null
              ? List<AddressHistory>.from(
                  map[DBSCheckModelSchema.historicalAddresses]
                      .map((x) => AddressHistory.fromMap(x)))
              : [],
          email: map[DBSCheckModelSchema.email],
          townOfBirth: map[DBSCheckModelSchema.townOfBirth],
          countryOfBirth: map[DBSCheckModelSchema.countryOfBirth],
          criminalRecord: map[DBSCheckModelSchema.criminalRecord],
          trueInformationConfirmation:
              map[DBSCheckModelSchema.trueInformationConfirmation],
          checksType: EnumHelpers.getChecksTypeFromString(
              map[DBSCheckModelSchema.checkType]),
          dbsProfileNumber: map[DBSCheckModelSchema.dbsProfileNumber],
        );
      } catch (e, s) {
        print('DBS historical name catch____${e}____$s');
        return null;
      }
    } else {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    var map = {
      DBSCheckModelSchema.email: email,
      DBSCheckModelSchema.townOfBirth: townOfBirth,
      DBSCheckModelSchema.countryOfBirth: countryOfBirth,
      DBSCheckModelSchema.criminalRecord: criminalRecord,
      DBSCheckModelSchema.trueInformationConfirmation:
          trueInformationConfirmation,
      DBSCheckModelSchema.checkType:
          EnumHelpers.getStringFromCheckType(checksType),
    };
    if (dbsProfileNumber != null) {
      map[DBSCheckModelSchema.dbsProfileNumber] = dbsProfileNumber;
    }
    return map;
  }
}

class HistoricalName {
  String firstName;
  String middleName;
  String surname;
  DateTime dateUsedFrom;
  DateTime dateUsedUntil;

  HistoricalName(
      {this.firstName,
      this.middleName,
      this.surname,
      this.dateUsedFrom,
      this.dateUsedUntil});

  factory HistoricalName.fromMap(Map map) {
    if (map != null && map.isNotEmpty) {
      try {
        var start = map[DBSCheckModelSchema.dateUsedFrom];
        var end = map[DBSCheckModelSchema.dateUsedUntil];
        return HistoricalName(
          firstName: map[DBSCheckModelSchema.firstName],
          middleName: map[DBSCheckModelSchema.middleName],
          surname: map[DBSCheckModelSchema.surname],
          dateUsedFrom: start != null && start is Timestamp
              ? start.toDate()
              : DateTime.tryParse(start),
          dateUsedUntil: end != null && end is Timestamp
              ? end.toDate()
              : DateTime.tryParse(end),
        );
      } catch (e, s) {
        print('DBS historical name catch____${e}____$s');
        return null;
      }
    } else {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      DBSCheckModelSchema.firstName: firstName,
      DBSCheckModelSchema.middleName: middleName,
      DBSCheckModelSchema.surname: surname,
      DBSCheckModelSchema.dateUsedFrom: Helpers.dateToString(dateUsedFrom),
      DBSCheckModelSchema.dateUsedUntil: Helpers.dateToString(dateUsedUntil),
    };
  }
}

class AddressHistory {
  AddressModel address;
  DateTime dateMovedIn;
  DateTime dateMovedOut;

  AddressHistory({
    this.address,
    this.dateMovedIn,
    this.dateMovedOut,
  });

  factory AddressHistory.fromMap(Map map) {
    if (map != null && map.isNotEmpty) {
      try {
        return AddressHistory(
          address: map[DBSCheckModelSchema.fullAddress] != null
              ? AddressModel.fromMap(
                  map: map[DBSCheckModelSchema.fullAddress]
                      [LocationSchema.address],
                )
              : null,
          dateMovedIn: DateTime.tryParse(map[DBSCheckModelSchema.dateMovedIn]),
          dateMovedOut:
              DateTime.tryParse(map[DBSCheckModelSchema.dateMovedOut]),
        );
      } catch (e, s) {
        print('DBS historical address catch____${e}____$s');
        return null;
      }
    } else {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      DBSCheckModelSchema.fullAddress: {
        LocationSchema.address: address.toJSON()
      },
      DBSCheckModelSchema.dateMovedIn: Helpers.dateToString(dateMovedIn),
      DBSCheckModelSchema.dateMovedOut: Helpers.dateToString(dateMovedOut),
    };
  }
}

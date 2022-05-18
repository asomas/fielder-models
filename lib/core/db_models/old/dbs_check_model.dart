import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/helpers/helpers.dart';
import 'package:fielder_models/core/db_models/old/address_model.dart';
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
              ? List<HistoricalName>.from(map[DBSCheckModelSchema.middleName]
                  .map((x) => HistoricalName.fromMap(x)))
              : [],
          addresses: map[DBSCheckModelSchema.fullAddress] != null
              ? List<AddressHistory>.from(map[DBSCheckModelSchema.fullAddress]
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
        return HistoricalName(
          firstName: map[DBSCheckModelSchema.firstName],
          middleName: map[DBSCheckModelSchema.middleName],
          surname: map[DBSCheckModelSchema.surname],
          dateUsedFrom:
              DateTime.tryParse(map[DBSCheckModelSchema.dateUsedFrom]),
          dateUsedUntil:
              DateTime.tryParse(map[DBSCheckModelSchema.dateUsedUntil]),
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
      //Todo update fields
      try {
        return AddressHistory(
          address: map[DBSCheckModelSchema.fullAddress],
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
    Map addressMap = address.toJSON();
    addressMap[DBSCheckModelSchema.dateMovedIn] =
        Helpers.dateToString(dateMovedIn);
    addressMap[DBSCheckModelSchema.dateMovedOut] =
        Helpers.dateToString(dateMovedOut);
    return addressMap;
  }
}

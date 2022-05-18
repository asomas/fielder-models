import 'package:fielder_models/core/db_models/helpers/helpers.dart';

import 'schema/dbs_check_model_schema.dart';

class DBSCheckModel {}

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
          dateUsedFrom: map[DBSCheckModelSchema.dateUsedFrom],
          dateUsedUntil: map[DBSCheckModelSchema.dateUsedUntil],
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

import 'package:fielder_models/core/db_models/worker/schema/occupationSchema.dart';

class OccupationModel {
  OccupationModel({
    this.occupationId,
    this.value,
  });

  String occupationId;
  String value;

  factory OccupationModel.fromJson(Map<String, dynamic> json) =>
      OccupationModel(
        occupationId: json[OccupationSchema.occupationId],
        value: json[OccupationSchema.value],
      );

  Map<String, dynamic> toJson() => {
        OccupationSchema.occupationId: occupationId,
        OccupationSchema.value: value,
      };
}

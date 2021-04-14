import 'package:fielder_models/core/db_models/worker/schema/locationSchema.dart';

class LocationDetail {
  LocationDetail({
    this.formattedAddress,
    this.lat,
    this.lng,
    this.name,
    this.placeId,
  });

  String formattedAddress;
  double lat;
  double lng;
  String name;
  String placeId;

  factory LocationDetail.fromJson(Map<String, dynamic> json) => LocationDetail(
        formattedAddress: json[LocationSchema.formattedAddress],
        lat: json[LocationSchema.lat].toDouble(),
        lng: json[LocationSchema.lng].toDouble(),
        name: json[LocationSchema.name],
        placeId: json[LocationSchema.placeId],
      );

  Map<String, dynamic> toJson() => {
        LocationSchema.formattedAddress: formattedAddress,
        LocationSchema.lat: lat,
        LocationSchema.lng: lng,
        LocationSchema.name: name,
        LocationSchema.placeId: placeId,
      };
}

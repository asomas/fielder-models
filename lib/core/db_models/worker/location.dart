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
        formattedAddress: json["formatted_address"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        name: json["name"],
        placeId: json["place_id"],
      );

  Map<String, dynamic> toJson() => {
        "formatted_address": formattedAddress,
        "lat": lat,
        "lng": lng,
        "name": name,
        "place_id": placeId,
      };
}

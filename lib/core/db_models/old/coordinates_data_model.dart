class CoordinatesModel {
  final double lat;
  final double lng;

  CoordinatesModel({
    this.lat,
    this.lng,
  });

  factory CoordinatesModel.fromMap(Map<String, dynamic> map) {
    return CoordinatesModel(lat: map[""]);
  }

  Map<String, dynamic> toJSON() {
    try {
      return {
        'lat': lat,
        'lng': lng,
      };
    } catch (e) {
      print('CoordinatesModel toJSON catch error: $e');
      return {};
    }
  }
}

class WorkerSearchResponse {
  final List<WorkerDataModel> hits;
  final int offset;
  final int limit;
  final int nbHits;
  final bool exhaustiveNbHits;
  final int processingTimeMs;
  final String query;

  WorkerSearchResponse({
    this.hits,
    this.offset,
    this.limit,
    this.nbHits,
    this.exhaustiveNbHits,
    this.processingTimeMs,
    this.query,
  });

  factory WorkerSearchResponse.fromJson(Map<String, dynamic> json) {
    //hits
    final List<dynamic> _hits = json['hits'] ?? [];
    List<WorkerDataModel> _allHitsArray = [];
    _hits.forEach((element) {
      final WorkerDataModel _qualification = WorkerDataModel.fromJson(element);
      if (_qualification != null) {
        _allHitsArray.add(_qualification);
      }
    });

    return WorkerSearchResponse(
      hits: _allHitsArray,
      offset: json['offset'] ?? 0,
      limit: json['limit'] ?? 0,
      nbHits: json['nbHits'] ?? 0,
      exhaustiveNbHits: json['exhaustiveNbHits'] ?? false,
      processingTimeMs: json['processingTimeMs'] ?? 0,
      query: json['query'] ?? '',
    );
  }
}

class WorkerDataModel {
  String id;
  String employerId;
  String firstName;
  String lastName;

  WorkerDataModel({
    this.id,
    this.employerId,
    this.firstName,
    this.lastName,
  });

  factory WorkerDataModel.fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      String id = json["id"];
      String firstName = json["first_name"];
      String employerId = json["employer_id"];
      if (id != null && firstName != null && employerId != null) {
        return WorkerDataModel(
          id: id,
          employerId: employerId,
          firstName: firstName,
          lastName: json["last_name"] ?? '',
        );
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "first_name": firstName,
        "last_name": lastName,
      };
}

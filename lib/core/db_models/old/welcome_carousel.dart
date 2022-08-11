import 'package:fielder_models/core/db_models/old/media_model.dart';

class WelcomeCarouselModel {
  List<MediaModel> data;

  WelcomeCarouselModel({this.data});

  factory WelcomeCarouselModel.fromMap(Map map) {
    try {
      return WelcomeCarouselModel(
          data: (map[WelcomeCarouselSchema.carouselData] as List)
              .map((e) => MediaModel.fromMap(e))
              .toList());
    } catch (e, s) {
      print('welcome carousel catch____${e}____$s');
      return null;
    }
  }
}

class WelcomeCarouselSchema {
  static const String carouselData = 'carousel_data';
  static const String media = 'media';
  static const String updatedAt = 'updated_at';
}

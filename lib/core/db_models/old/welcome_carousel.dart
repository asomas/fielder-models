import 'package:fielder_models/core/db_models/old/media_model.dart';
import 'package:fielder_models/core/db_models/old/schema/table_collection_schema.dart';

class WelcomeCarouselModel {
  List<MediaModel> data;

  WelcomeCarouselModel({this.data});

  factory WelcomeCarouselModel.fromMap(Map map) {
    try {
      return WelcomeCarouselModel(
          data: (map[FbCollections.images] as List)
              .map((e) => MediaModel.fromUrl(e))
              .toList());
    } catch (e, s) {
      print('welcome carousel catch____${e}____$s');
      return null;
    }
  }
}

import 'package:fielder_models/core/db_models/old/schema/table_collection_schema.dart';
import 'package:fielder_models/core/enums/enums.dart';
import 'package:path/path.dart' as p;

class WelcomeCarouselModel {
  List<WelcomeCarouselItem> data;

  WelcomeCarouselModel({this.data});

  factory WelcomeCarouselModel.fromMap(Map map) {
    try {
      return WelcomeCarouselModel(
          data: (map[FbCollections.images] as List)
              .map((e) => WelcomeCarouselItem.fromString(e))
              .toList());
    } catch (e, s) {
      print('welcome carousel catch____${e}____$s');
      return null;
    }
  }
}

class WelcomeCarouselItem {
  static const List<String> imageFormats = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'svg',
    'apng',
    'webp'
  ];
  static const List<String> videoFormats = [
    'mp4',
    'avi',
    'wmv',
    'mov',
    'mkv',
    'webm'
  ];
  String url;
  WelcomeCarouselItemType itemType;

  WelcomeCarouselItem({this.url, this.itemType});

  factory WelcomeCarouselItem.fromString(String data) {
    try {
      return WelcomeCarouselItem(
        url: data,
        itemType: getUrlType(data),
      );
    } catch (e, s) {
      print('welcome carousel item catch____${e}____$s');
      return null;
    }
  }

  static WelcomeCarouselItemType getUrlType(String url) {
    Uri uri = Uri.parse(url);
    String typeString = p.extension(uri.path).replaceAll('.', "");
    if (videoFormats.contains(typeString.toLowerCase())) {
      return WelcomeCarouselItemType.Video;
    } else {
      return WelcomeCarouselItemType.Image;
    }
  }
}

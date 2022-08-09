import 'package:fielder_models/core/db_models/helpers/helpers.dart';
import 'package:fielder_models/core/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

class MediaModel {
  final String path;
  final MediaType type;

  const MediaModel({
    @required this.path,
    @required this.type,
  });
  bool get isValid => path?.isNotEmpty??false;

  bool get isLocal => Helpers.isUrl(path);

  bool get isImage => type == MediaType.Image;
  bool get isVideo => type == MediaType.Video;
  bool get isYoutubeVideo => type == MediaType.YoutubeVideo;

  factory MediaModel.fromUrl(String url) {
    try {
      return MediaModel(
        path: url,
        type: _getUrlType(url),
      );
    } catch (e, s) {
      print('media model catch____${e}____$s');
      return null;
    }
  }

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      path: json['path'],
      type: _getUrlType(json['path']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
    };
  }

  MediaModel copyWith(String path, MediaType type) {
    return MediaModel(
      path: path ?? this.path,
      type: type ?? this.type,
    );
  }

  static const List<String> imageFormats = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'svg',
    'apng',
    'webp',
  ];
  static const List<String> videoFormats = [
    'mp4',
    'avi',
    'wmv',
    'mov',
    'mkv',
    'webm',
  ];

  static MediaType _getUrlType(String url) {
    if (Helpers.isYoutubeLink(url)) {
      return MediaType.YoutubeVideo;
    }
    Uri uri = Uri.parse(url);
    String typeString = p.extension(uri.path).replaceAll('.', "");
    if (videoFormats.contains(typeString.toLowerCase())) {
      return MediaType.Video;
    } else {
      return MediaType.Image;
    }
  }
}

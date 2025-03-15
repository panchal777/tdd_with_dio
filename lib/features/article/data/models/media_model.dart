import 'package:json_annotation/json_annotation.dart';

part 'media_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MediaModel {
  String? type;
  String? subtype;
  String? caption;
  String? copyright;
  int? approvedForSyndication;
  @JsonKey(name: "media-metadata")
  List<MediaMetaDataModel>? mediaMetadata;

  MediaModel({
    this.type,
    this.subtype,
    this.caption,
    this.copyright,
    this.approvedForSyndication,
    this.mediaMetadata,
  });

  factory MediaModel.fromJson(json) => _$MediaModelFromJson(json);

  toJson() => _$MediaModelToJson(this);

  static List<MediaModel> fromJsonList(List json) {
    return json.map((e) => MediaModel.fromJson(e)).toList();
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MediaMetaDataModel {
  String? url;
  String? format;
  int? height;
  int? width;

  MediaMetaDataModel({this.url, this.format, this.height, this.width});

  factory MediaMetaDataModel.fromJson(json) =>
      _$MediaMetaDataModelFromJson(json);

  toJson() => _$MediaMetaDataModelToJson(this);

  static List<MediaMetaDataModel> fromJsonList(List json) {
    return json.map((e) => MediaMetaDataModel.fromJson(e)).toList();
  }
}

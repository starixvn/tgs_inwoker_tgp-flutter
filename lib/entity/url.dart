import 'package:json_annotation/json_annotation.dart';
part 'url.g.dart';

@JsonSerializable()

class Url {
  Url();

  String url;

  factory Url.fromJson(Map<String, dynamic> json) => _$UrlFromJson(json);
  Map<String, dynamic> toJson() => _$UrlToJson(this);

}
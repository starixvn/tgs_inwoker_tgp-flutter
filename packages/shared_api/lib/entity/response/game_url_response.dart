
import 'package:json_annotation/json_annotation.dart';
part 'game_url_response.g.dart';

@JsonSerializable()

class GameUrlResponse {
  GameUrlResponse( this.url);

  String url;

  factory GameUrlResponse.fromJson(Map<String, dynamic> json) => _$GameUrlResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GameUrlResponseToJson(this);
}

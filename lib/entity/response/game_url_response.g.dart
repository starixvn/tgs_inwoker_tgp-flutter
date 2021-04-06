// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_url_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameUrlResponse _$GameUrlResponseFromJson(Map<String, dynamic> json) {
  return GameUrlResponse(
    json['err'] as int,
    json['errmsg'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$GameUrlResponseToJson(GameUrlResponse instance) =>
    <String, dynamic>{
      'err': instance.code,
      'errmsg': instance.msg,
      'url': instance.url,
    };

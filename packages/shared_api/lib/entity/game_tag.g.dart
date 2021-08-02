// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameTag _$GameTagFromJson(Map<String, dynamic> json) {
  return GameTag()
    ..isNew = json['new'] as bool
    ..isHot = json['hot'] as bool
    ..isRecommend = json['recommend'] as bool;
}

Map<String, dynamic> _$GameTagToJson(GameTag instance) => <String, dynamic>{
      'new': instance.isNew,
      'hot': instance.isHot,
      'recommend': instance.isRecommend,
    };

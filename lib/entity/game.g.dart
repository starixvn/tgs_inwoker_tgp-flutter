// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) {
  return Game()
    ..id = json['id'] as int
    ..code = json['code'] as String
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..gamePlatformCode = json['gpcode'] as String
    ..isActive = json['isactive'] as bool
    ..type = json['type'] as int
    ..tag = json['tag'] == null
        ? null
        : GameTag.fromJson(json['tag'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'gpcode': instance.gamePlatformCode,
      'isactive': instance.isActive,
      'type': instance.type,
      'tag': instance.tag,
    };

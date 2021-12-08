// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      json['id'] as int,
      json['code'] as String,
      json['name'] as String,
      json['description'] as String?,
      json['gpcode'] as String,
      json['isactive'] as bool,
      $enumDecode(_$GameTypeEnumMap, json['type']),
      GameTag.fromJson(json['tag'] as Map<String, dynamic>),
      json['localizedName'] as String?,
      json['isFavourite'] as bool?,
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'gpcode': instance.gamePlatformCode,
      'isactive': instance.isActive,
      'type': _$GameTypeEnumMap[instance.type],
      'tag': instance.tag,
      'localizedName': instance.localizedName,
      'isFavourite': instance.isFavourite,
    };

const _$GameTypeEnumMap = {
  GameType.Sportsbook: 1,
  GameType.VirtualSports: 2,
  GameType.VirtualSportsLobby: 3,
  GameType.ESports: 4,
  GameType.LiveDealer: 5,
  GameType.LiveDealerLobby: 6,
  GameType.CardGame: 7,
  GameType.CardGameLobby: 8,
  GameType.Fishing: 9,
  GameType.FishingLobby: 10,
  GameType.Arcade: 11,
  GameType.ArcadeLobby: 12,
  GameType.Lottery: 13,
  GameType.LotteryLobby: 14,
  GameType.Slot: 15,
  GameType.EGame: 16,
};

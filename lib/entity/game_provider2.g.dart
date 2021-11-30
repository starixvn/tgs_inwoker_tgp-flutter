// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_provider2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameProvider2 _$GameProvider2FromJson(Map<String, dynamic> json) =>
    GameProvider2(
      $enumDecode(_$GameTypeEnumMap, json['gameType']),
      json['code'] as String,
      json['name'] as String,
      json['description'] as String?,
      json['status'] as int,
    );

Map<String, dynamic> _$GameProvider2ToJson(GameProvider2 instance) =>
    <String, dynamic>{
      'gameType': _$GameTypeEnumMap[instance.gameType],
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'status': instance.status,
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

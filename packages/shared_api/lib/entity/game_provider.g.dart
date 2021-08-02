// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameProvider _$GameProviderFromJson(Map<String, dynamic> json) {
  return GameProvider()
    ..code = json['code'] as String
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..status = json['status'] as int
    ..transferWallet = json['transferwallet'] as bool
    ..gameTypes = (json['gametypes'] as List)
        ?.map((e) => _$enumDecodeNullable(_$GameTypeEnumMap, e))
        ?.toList();
}

Map<String, dynamic> _$GameProviderToJson(GameProvider instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'status': instance.status,
      'transferwallet': instance.transferWallet,
      'gametypes':
          instance.gameTypes?.map((e) => _$GameTypeEnumMap[e])?.toList(),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

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

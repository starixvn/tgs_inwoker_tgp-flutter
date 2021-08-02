// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bet_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BetTransaction _$BetTransactionFromJson(Map<String, dynamic> json) {
  return BetTransaction()
    ..id = json['id'] as String
    ..createdOn = json['createdOn'] as String
    ..gameProviderName = json['gameProviderName'] as String
    ..betAmount = (json['betAmount'] as num)?.toDouble()
    ..validBetAmount = (json['validBetAmount'] as num)?.toDouble()
    ..winLoss = (json['winLoss'] as num)?.toDouble()
    ..gameName = json['gameName'] as String;
}

Map<String, dynamic> _$BetTransactionToJson(BetTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdOn': instance.createdOn,
      'gameProviderName': instance.gameProviderName,
      'betAmount': instance.betAmount,
      'validBetAmount': instance.validBetAmount,
      'winLoss': instance.winLoss,
      'gameName': instance.gameName,
    };

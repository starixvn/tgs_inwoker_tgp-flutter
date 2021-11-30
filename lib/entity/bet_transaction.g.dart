// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bet_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BetTransaction _$BetTransactionFromJson(Map<String, dynamic> json) =>
    BetTransaction(
      json['id'] as String,
      json['createdOn'] as String,
      json['gameProviderName'] as String,
      (json['betAmount'] as num).toDouble(),
      (json['validBetAmount'] as num).toDouble(),
      (json['winLoss'] as num).toDouble(),
      json['gameName'] as String,
    );

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

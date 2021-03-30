// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyTransaction _$DailyTransactionFromJson(Map<String, dynamic> json) {
  return DailyTransaction()
    ..betTime = json['bet_time'] as String
    ..betAmount = json['bet_amount']
    ..winLoss = json['win_loss']
    ..turnover = json['turnover'];
}

Map<String, dynamic> _$DailyTransactionToJson(DailyTransaction instance) =>
    <String, dynamic>{
      'bet_time': instance.betTime,
      'bet_amount': instance.betAmount,
      'win_loss': instance.winLoss,
      'turnover': instance.turnover,
    };

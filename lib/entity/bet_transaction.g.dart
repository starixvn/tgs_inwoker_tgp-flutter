// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bet_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BetTransaction _$BetTransactionFromJson(Map<String, dynamic> json) {
  return BetTransaction()
    ..betId = json['bet_id'] as String
    ..thirdpartyParentId = json['thirdparty_parent_id'] as int
    ..thirdpartyId = json['thirdparty_id'] as int
    ..thirdpartyCode = json['thirdparty_code'] as String
    ..betTime = json['bet_time'] as String
    ..realBetAmount = json['real_bet_amount'] as String
    ..winLoss = json['win_loss'] as String
    ..realTurnover = json['real_turnover'] as String
    ..rebateTurnover = json['rebate_turnover'] as String
    ..betContent = json['bet_content'] as String;
}

Map<String, dynamic> _$BetTransactionToJson(BetTransaction instance) =>
    <String, dynamic>{
      'bet_id': instance.betId,
      'thirdparty_parent_id': instance.thirdpartyParentId,
      'thirdparty_id': instance.thirdpartyId,
      'thirdparty_code': instance.thirdpartyCode,
      'bet_time': instance.betTime,
      'real_bet_amount': instance.realBetAmount,
      'win_loss': instance.winLoss,
      'real_turnover': instance.realTurnover,
      'rebate_turnover': instance.rebateTurnover,
      'bet_content': instance.betContent,
    };

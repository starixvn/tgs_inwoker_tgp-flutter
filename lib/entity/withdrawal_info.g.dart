// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawalInfo _$WithdrawalInfoFromJson(Map<String, dynamic> json) {
  return WithdrawalInfo()
    ..balance = json['balance'] as String
    ..limitWithdrawal = json['limit_withdrawal'] as String
    ..limitTurnover = json['limit_turnover'] as String
    ..canWithdrawal = json['can_withdrawal'] as String
    ..bonusLimitWithdrawal = json['bonus_limit_withdrawal'] as String
    ..bonusLimitList = (json['bonus_limit_list'] as List)
        ?.map((e) =>
            e == null ? null : BonusLimit.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$WithdrawalInfoToJson(WithdrawalInfo instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'limit_withdrawal': instance.limitWithdrawal,
      'limit_turnover': instance.limitTurnover,
      'can_withdrawal': instance.canWithdrawal,
      'bonus_limit_withdrawal': instance.bonusLimitWithdrawal,
      'bonus_limit_list': instance.bonusLimitList,
    };

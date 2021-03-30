// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_bonus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepositBonus _$DepositBonusFromJson(Map<String, dynamic> json) {
  return DepositBonus()
    ..bospId = json['bosp_id'] as int
    ..bospTitle = json['bosp_title'] as String
    ..bonusId = json['bonus_id'] as int
    ..turnoverMultiple = json['turnover_multiple'] as String
    ..title = json['title'] as String
    ..remark = json['remark'] as String
    ..startTime = json['start_time'] as String
    ..endTime = json['end_time'] as String
    ..bonus = (json['bonus'] as num)?.toDouble()
    ..turnover = (json['turnover'] as num)?.toDouble()
    ..turnoverLimit = json['turnover_limit'] as String;
}

Map<String, dynamic> _$DepositBonusToJson(DepositBonus instance) =>
    <String, dynamic>{
      'bosp_id': instance.bospId,
      'bosp_title': instance.bospTitle,
      'bonus_id': instance.bonusId,
      'turnover_multiple': instance.turnoverMultiple,
      'title': instance.title,
      'remark': instance.remark,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'bonus': instance.bonus,
      'turnover': instance.turnover,
      'turnover_limit': instance.turnoverLimit,
    };

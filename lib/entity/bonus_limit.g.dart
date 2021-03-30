// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bonus_limit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BonusLimit _$BonusLimitFromJson(Map<String, dynamic> json) {
  return BonusLimit()
    ..totalAmount = json['total_amount'] as String
    ..limit = json['limit'] as String;
}

Map<String, dynamic> _$BonusLimitToJson(BonusLimit instance) =>
    <String, dynamic>{
      'total_amount': instance.totalAmount,
      'limit': instance.limit,
    };

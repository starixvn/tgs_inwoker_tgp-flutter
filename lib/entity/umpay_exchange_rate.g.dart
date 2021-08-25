// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'umpay_exchange_rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UmPayExchangeRate _$UmPayExchangeRateFromJson(Map<String, dynamic> json) {
  return UmPayExchangeRate()
    ..rate = (json['rate'] as num)?.toDouble()
    ..fee = (json['fee'] as num)?.toDouble()
    ..inRate = (json['in_rate'] as num)?.toDouble()
    ..outRate = (json['out_rate'] as num)?.toDouble();
}

Map<String, dynamic> _$UmPayExchangeRateToJson(UmPayExchangeRate instance) =>
    <String, dynamic>{
      'rate': instance.rate,
      'fee': instance.fee,
      'in_rate': instance.inRate,
      'out_rate': instance.outRate,
    };

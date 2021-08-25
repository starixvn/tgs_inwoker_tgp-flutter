// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'umpay_exchange_rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UmPayExchangeRate _$UmPayExchangeRateFromJson(Map<String, dynamic> json) {
  return UmPayExchangeRate()
    ..rate = json['rate'] as double
    ..fee = json['fee'] as double
    ..inRate = json['in_rate'] as double
    ..outRate = json['out_rate'] as double;
}

Map<String, dynamic> _$UmPayExchangeRateToJson(UmPayExchangeRate instance) =>
    <String, dynamic>{
      'rate': instance.rate,
      'fee': instance.fee,
      'in_rate': instance.inRate,
      'out_rate': instance.outRate,
    };

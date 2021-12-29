// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'umpay_exchange_rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UmPayExchangeRate _$UmPayExchangeRateFromJson(Map<String, dynamic> json) =>
    UmPayExchangeRate(
      (json['rate'] as num?)?.toDouble(),
      (json['fee'] as num?)?.toDouble(),
      (json['in_rate'] as num?)?.toDouble(),
      (json['out_rate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UmPayExchangeRateToJson(UmPayExchangeRate instance) =>
    <String, dynamic>{
      'rate': instance.rate,
      'fee': instance.fee,
      'in_rate': instance.inRate,
      'out_rate': instance.outRate,
    };

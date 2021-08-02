// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeRate _$ExchangeRateFromJson(Map<String, dynamic> json) {
  return ExchangeRate(
    json['buyprice'] as String,
    json['sellprice'] as String,
    json['updatetime'] as String,
  );
}

Map<String, dynamic> _$ExchangeRateToJson(ExchangeRate instance) =>
    <String, dynamic>{
      'buyprice': instance.buyPrice,
      'sellprice': instance.sellPrice,
      'updatetime': instance.updateTime,
    };

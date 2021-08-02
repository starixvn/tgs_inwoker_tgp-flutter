// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankCard _$BankCardFromJson(Map<String, dynamic> json) {
  return BankCard()
    ..id = json['id'] as String
    ..paymentChannelId = json['paymentchannelid'] as String
    ..bankType = _$enumDecodeNullable(_$BankTypeEnumMap, json['banktype'])
    ..bankDetail = json['detail'] == null
        ? null
        : BankDetail.fromJson(json['detail'] as Map<String, dynamic>);
}

Map<String, dynamic> _$BankCardToJson(BankCard instance) => <String, dynamic>{
      'id': instance.id,
      'paymentchannelid': instance.paymentChannelId,
      'banktype': _$BankTypeEnumMap[instance.bankType],
      'detail': instance.bankDetail,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$BankTypeEnumMap = {
  BankType.BANK: 'Bank',
  BankType.CRYPTO: 'Crypto',
};

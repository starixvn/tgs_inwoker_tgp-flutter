// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return Payment()
    ..id = json['id'] as String
    ..bankType = _$enumDecodeNullable(_$BankTypeEnumMap, json['banktype'])
    ..channelName = json['channelname'] as String
    ..transferLimit = json['transferlimit'] == null
        ? null
        : TransferLimit.fromJson(json['transferlimit'] as Map<String, dynamic>)
    ..paymentId = json['paymentid'] as String
    ..paymentCode = json['paymentcode'] as String
    ..methodId = json['methodid'] as String
    ..methodCode = json['methodcode'] as String
    ..order = json['displayorder'] as int;
}

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'banktype': _$BankTypeEnumMap[instance.bankType],
      'channelname': instance.channelName,
      'transferlimit': instance.transferLimit,
      'paymentid': instance.paymentId,
      'paymentcode': instance.paymentCode,
      'methodid': instance.methodId,
      'methodcode': instance.methodCode,
      'displayorder': instance.order,
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

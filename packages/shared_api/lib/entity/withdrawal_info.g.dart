// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawalInfo _$WithdrawalInfoFromJson(Map<String, dynamic> json) {
  return WithdrawalInfo()
    ..id = json['id'] as String
    ..bankType = _$enumDecodeNullable(_$BankTypeEnumMap, json['banktype'])
    ..channelId = json['channelid'] as String
    ..channelName = json['channelname'] as String
    ..channelCode = json['channelcode'] as String
    ..methodCode = json['methodcode'] as String
    ..methodId = json['methodid'] as String
    ..paymentCode = json['paymentcode'] as String
    ..paymentId = json['paymentid'] as String
    ..transferLimit = json['transferlimit'] == null
        ? null
        : TransferLimit.fromJson(json['transferlimit'] as Map<String, dynamic>)
    ..bankExtendedInfo = json['extended'] == null
        ? null
        : BankExtendedInfo.fromJson(json['extended'] as Map<String, dynamic>);
}

Map<String, dynamic> _$WithdrawalInfoToJson(WithdrawalInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'banktype': _$BankTypeEnumMap[instance.bankType],
      'channelid': instance.channelId,
      'channelname': instance.channelName,
      'channelcode': instance.channelCode,
      'methodcode': instance.methodCode,
      'methodid': instance.methodId,
      'paymentcode': instance.paymentCode,
      'paymentid': instance.paymentId,
      'transferlimit': instance.transferLimit,
      'extended': instance.bankExtendedInfo,
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

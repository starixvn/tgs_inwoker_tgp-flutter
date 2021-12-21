// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      json['id'] as String?,
      $enumDecodeNullable(_$BankTypeEnumMap, json['banktype']),
      json['channelname'] as String?,
      json['transferlimit'] == null
          ? null
          : TransferLimit.fromJson(
              json['transferlimit'] as Map<String, dynamic>),
      json['paymentid'] as String?,
      json['paymentcode'] as String?,
      json['methodid'] as String?,
      json['methodcode'] as String?,
      json['displayorder'] as int?,
    )..qrCode = json['extended'] == null
        ? null
        : PaymentQrCode.fromJson(json['extended'] as Map<String, dynamic>);

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
      'extended': instance.qrCode,
    };

const _$BankTypeEnumMap = {
  BankType.BANK: 'Bank',
  BankType.CRYPTO: 'Crypto',
  BankType.THIRD_PARTY: 'ThirdParty',
  BankType.FPS: 'FPS',
};

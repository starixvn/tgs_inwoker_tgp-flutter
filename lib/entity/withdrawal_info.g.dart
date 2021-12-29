// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawalInfo _$WithdrawalInfoFromJson(Map<String, dynamic> json) =>
    WithdrawalInfo(
      json['id'] as String?,
      $enumDecodeNullable(_$BankTypeEnumMap, json['banktype']),
      json['channelid'] as String?,
      json['channelname'] as String?,
      json['channelcode'] as String?,
      json['methodcode'] as String?,
      json['methodid'] as String?,
      json['paymentcode'] as String?,
      json['paymentid'] as String?,
      json['transferlimit'] == null
          ? null
          : TransferLimit.fromJson(
              json['transferlimit'] as Map<String, dynamic>),
      json['extended'] == null
          ? null
          : BankExtendedInfo.fromJson(json['extended'] as Map<String, dynamic>),
    );

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

const _$BankTypeEnumMap = {
  BankType.BANK: 'Bank',
  BankType.CRYPTO: 'Crypto',
  BankType.THIRD_PARTY: 'ThirdParty',
  BankType.FPS: 'FPS',
};

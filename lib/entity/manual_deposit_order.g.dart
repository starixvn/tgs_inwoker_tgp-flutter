// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manual_deposit_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManualDepositOrder _$ManualDepositOrderFromJson(Map<String, dynamic> json) =>
    ManualDepositOrder(
      json['methodname'] as String?,
      json['channelname'] as String?,
      (json['amount'] as num).toDouble(),
      json['bankname'] as String?,
      json['bankaccountname'] as String?,
      json['bankaccount'] as String?,
    )..qrCode = json['qrcode'] as String?;

Map<String, dynamic> _$ManualDepositOrderToJson(ManualDepositOrder instance) =>
    <String, dynamic>{
      'methodname': instance.methodName,
      'channelname': instance.channelName,
      'amount': instance.amount,
      'bankname': instance.bankName,
      'bankaccountname': instance.bankAccountName,
      'bankaccount': instance.bankAccount,
      'qrcode': instance.qrCode,
    };

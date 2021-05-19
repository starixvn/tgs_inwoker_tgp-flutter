// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manual_deposit_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManualDepositOrder _$ManualDepositOrderFromJson(Map<String, dynamic> json) {
  return ManualDepositOrder()
    ..methodName = json['methodname'] as String
    ..channelName = json['channelname'] as String
    ..amount = (json['amount'] as num)?.toDouble()
    ..bankName = json['bankname'] as String
    ..bankAccountName = json['bankaccountname'] as String
    ..bankAccount = json['bankaccount'] as String;
}

Map<String, dynamic> _$ManualDepositOrderToJson(ManualDepositOrder instance) =>
    <String, dynamic>{
      'methodname': instance.methodName,
      'channelname': instance.channelName,
      'amount': instance.amount,
      'bankname': instance.bankName,
      'bankaccountname': instance.bankAccountName,
      'bankaccount': instance.bankAccount,
    };

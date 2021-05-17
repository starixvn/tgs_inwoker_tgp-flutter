// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepositOrder _$DepositOrderFromJson(Map<String, dynamic> json) {
  return DepositOrder()
    ..methodName = json['methodname'] as String
    ..channelName = json['channelname'] as String
    ..amount = (json['amount'] as num)?.toDouble()
    ..bankName = json['bankname'] as String
    ..bankAccountName = json['bankaccountname'] as String
    ..bankAccount = json['bankaccount'] as String;
}

Map<String, dynamic> _$DepositOrderToJson(DepositOrder instance) =>
    <String, dynamic>{
      'methodname': instance.methodName,
      'channelname': instance.channelName,
      'amount': instance.amount,
      'bankname': instance.bankName,
      'bankaccountname': instance.bankAccountName,
      'bankaccount': instance.bankAccount,
    };

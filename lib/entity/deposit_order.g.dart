// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepositOrder _$DepositOrderFromJson(Map<String, dynamic> json) {
  return DepositOrder()
    ..methodName = json['methodName'] as String
    ..channelName = json['channelName'] as String
    ..amount = (json['amount'] as num)?.toDouble()
    ..bankName = json['bankName'] as String
    ..bankAccountName = json['bankAccountName'] as String
    ..bankAccount = json['bankAccount'] as String;
}

Map<String, dynamic> _$DepositOrderToJson(DepositOrder instance) =>
    <String, dynamic>{
      'methodName': instance.methodName,
      'channelName': instance.channelName,
      'amount': instance.amount,
      'bankName': instance.bankName,
      'bankAccountName': instance.bankAccountName,
      'bankAccount': instance.bankAccount,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferTransaction _$TransferTransactionFromJson(Map<String, dynamic> json) {
  return TransferTransaction()
    ..from = json['from'] as String
    ..to = json['to'] as String
    ..amount = (json['amount'] as num)?.toDouble()
    ..balanceTime = json['balancetime'] as String;
}

Map<String, dynamic> _$TransferTransactionToJson(
        TransferTransaction instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'amount': instance.amount,
      'balancetime': instance.balanceTime,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferTransaction _$TransferTransactionFromJson(Map<String, dynamic> json) =>
    TransferTransaction(
      json['from'] as String,
      json['to'] as String,
      (json['amount'] as num).toDouble(),
      json['balancetime'] as String,
    );

Map<String, dynamic> _$TransferTransactionToJson(
        TransferTransaction instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'amount': instance.amount,
      'balancetime': instance.balanceTime,
    };

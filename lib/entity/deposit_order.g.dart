// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepositOrder _$DepositOrderFromJson(Map<String, dynamic> json) {
  return DepositOrder()
    ..id = json['id'] as int
    ..sn = json['sn'] as String
    ..orderTime = json['order_time'] as String
    ..amount = json['amount'] as String;
}

Map<String, dynamic> _$DepositOrderToJson(DepositOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sn': instance.sn,
      'order_time': instance.orderTime,
      'amount': instance.amount,
    };

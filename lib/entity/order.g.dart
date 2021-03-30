// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    json['id'] as int,
    json['payment_id'] as int,
    json['payment_type_id'] as int,
    json['type_class'] as String,
    json['type_title'] as String,
    json['sn'] as String,
    json['amount'] as String,
    json['is_qrcode'] as int,
    json['is_transfer'] as int,
    json['url'] as String,
    json['qrcode'] as String,
    json['content'],
    json['expired_time'] as int,
    json['order_time'] as String,
  )..params = json['params'] == null
      ? null
      : Params.fromJson(json['params'] as Map<String, dynamic>);
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'payment_id': instance.paymentId,
      'payment_type_id': instance.paymentTypeId,
      'type_class': instance.typeClass,
      'type_title': instance.typeTitle,
      'sn': instance.sn,
      'amount': instance.amount,
      'is_qrcode': instance.isQrcode,
      'is_transfer': instance.isTransfer,
      'url': instance.url,
      'qrcode': instance.qrcode,
      'content': instance.content,
      'expired_time': instance.expiredTime,
      'order_time': instance.orderTime,
      'params': instance.params,
    };

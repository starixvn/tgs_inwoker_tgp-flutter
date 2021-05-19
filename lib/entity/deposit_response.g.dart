// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepositResponse _$DepositResponseFromJson(Map<String, dynamic> json) {
  return DepositResponse()
    ..paymentId = json['payment_id'] as int
    ..isQrcode = json['is_qrcode'] as int
    ..isTransfer = json['is_transfer'] as int
    ..url = json['url']
    ..qrcode = json['qrcode'] as String
    ..params = json['params'] == null
        ? null
        : Params.fromJson(json['params'] as Map<String, dynamic>)
    ..order = json['order'] == null
        ? null
        : ManualDepositOrder.fromJson(json['order'] as Map<String, dynamic>)
    ..expiredTime = json['expired_time'] as int;
}

Map<String, dynamic> _$DepositResponseToJson(DepositResponse instance) =>
    <String, dynamic>{
      'payment_id': instance.paymentId,
      'is_qrcode': instance.isQrcode,
      'is_transfer': instance.isTransfer,
      'url': instance.url,
      'qrcode': instance.qrcode,
      'params': instance.params,
      'order': instance.order,
      'expired_time': instance.expiredTime,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return Payment()
    ..id = json['id'] as String
    ..channelName = json['channelname'] as String
    ..transferLimit = json['transferlimit'] == null
        ? null
        : TransferLimit.fromJson(json['transferlimit'] as Map<String, dynamic>)
    ..paymentId = json['paymentid'] as String
    ..paymentCode = json['paymentcode'] as String
    ..methodId = json['methodid'] as String
    ..methodCode = json['methodcode'] as String;
}

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'channelname': instance.channelName,
      'transferlimit': instance.transferLimit,
      'paymentid': instance.paymentId,
      'paymentcode': instance.paymentCode,
      'methodid': instance.methodId,
      'methodcode': instance.methodCode,
    };

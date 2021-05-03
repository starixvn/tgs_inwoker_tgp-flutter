// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return Payment()
    ..id = json['id'] as String
    ..channelName = json['channelName'] as String
    ..transferLimit = json['transferLimit'] == null
        ? null
        : TransferLimit.fromJson(json['transferLimit'] as Map<String, dynamic>)
    ..paymentId = json['payment_id'] as String
    ..paymentCode = json['paymentCode'] as String
    ..methodId = json['methodId'] as String
    ..methodCode = json['methodCode'] as String;
}

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'channelName': instance.channelName,
      'transferLimit': instance.transferLimit,
      'payment_id': instance.paymentId,
      'paymentCode': instance.paymentCode,
      'methodId': instance.methodId,
      'methodCode': instance.methodCode,
    };

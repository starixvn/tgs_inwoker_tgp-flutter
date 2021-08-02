// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentResponse _$PaymentResponseFromJson(Map<String, dynamic> json) {
  return PaymentResponse()
    ..order = json['order'] == null
        ? null
        : Order.fromJson(json['order'] as Map<String, dynamic>)
    ..payments = (json['payments'] as List)
        ?.map((e) =>
            e == null ? null : Payment.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PaymentResponseToJson(PaymentResponse instance) =>
    <String, dynamic>{
      'order': instance.order,
      'payments': instance.payments,
    };

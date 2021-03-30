// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return Payment()
    ..id = json['id'] as int
    ..paymentId = json['payment_id'] as int
    ..title = json['title'] as String
    ..min = json['min'] as int
    ..max = json['max'] as int
    ..fee = json['fee']
    ..typeTitle = json['type_title'] as String
    ..typeClass = json['type_class'] as String
    ..banks = (json['banks'] as List)
        ?.map((e) =>
            e == null ? null : PaymentBank.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..amountOptions =
        (json['amount_options'] as List)?.map((e) => e as int)?.toList();
}

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'payment_id': instance.paymentId,
      'title': instance.title,
      'min': instance.min,
      'max': instance.max,
      'fee': instance.fee,
      'type_title': instance.typeTitle,
      'type_class': instance.typeClass,
      'banks': instance.banks,
      'amount_options': instance.amountOptions,
    };

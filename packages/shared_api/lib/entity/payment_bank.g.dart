// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentBank _$PaymentBankFromJson(Map<String, dynamic> json) {
  return PaymentBank()
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..bankName = json['bank_name'] as String;
}

Map<String, dynamic> _$PaymentBankToJson(PaymentBank instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'bank_name': instance.bankName,
    };

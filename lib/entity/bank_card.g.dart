// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankCard _$BankCardFromJson(Map<String, dynamic> json) {
  return BankCard()
    ..id = json['id'] as int
    ..bankName = json['bank_name'] as String
    ..bankAccount = json['bank_account'] as String
    ..isDefault = json['is_default'] as int;
}

Map<String, dynamic> _$BankCardToJson(BankCard instance) => <String, dynamic>{
      'id': instance.id,
      'bank_name': instance.bankName,
      'bank_account': instance.bankAccount,
      'is_default': instance.isDefault,
    };

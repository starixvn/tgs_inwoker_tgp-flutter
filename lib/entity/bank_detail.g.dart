// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankDetail _$BankDetailFromJson(Map<String, dynamic> json) {
  return BankDetail()
    ..address = json['address'] as String
    ..bankAccount = json['bankAccount'] as String;
}

Map<String, dynamic> _$BankDetailToJson(BankDetail instance) =>
    <String, dynamic>{
      'address': instance.address,
      'bankAccount': instance.bankAccount,
    };

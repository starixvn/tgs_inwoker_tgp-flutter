// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankDetail _$BankDetailFromJson(Map<String, dynamic> json) => BankDetail(
      json['address'] as String?,
      json['bankAccount'] as String?,
      json['phone'] as String?,
      json['username'] as String?,
    );

Map<String, dynamic> _$BankDetailToJson(BankDetail instance) =>
    <String, dynamic>{
      'address': instance.address,
      'bankAccount': instance.bankAccount,
      'phone': instance.phone,
      'username': instance.username,
    };

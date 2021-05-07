// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_extended_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankExtendedInfo _$BankExtendedInfoFromJson(Map<String, dynamic> json) {
  return BankExtendedInfo()
    ..name = json['name'] as String
    ..bankAccount = json['bankAccount'] as String;
}

Map<String, dynamic> _$BankExtendedInfoToJson(BankExtendedInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'bankAccount': instance.bankAccount,
    };

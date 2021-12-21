// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_redirect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepositRedirect _$DepositRedirectFromJson(Map<String, dynamic> json) =>
    DepositRedirect(
      json['formid'] as String?,
      json['paymenturl'] as String?,
    );

Map<String, dynamic> _$DepositRedirectToJson(DepositRedirect instance) =>
    <String, dynamic>{
      'formid': instance.formId,
      'paymenturl': instance.paymentUrl,
    };

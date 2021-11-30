// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_redirect_applepay.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepositRedirectApplePay _$DepositRedirectApplePayFromJson(
        Map<String, dynamic> json) =>
    DepositRedirectApplePay(
      json['formid'] as String,
      json['paymenturl'] as String,
      json['errormsg'] as String,
    );

Map<String, dynamic> _$DepositRedirectApplePayToJson(
        DepositRedirectApplePay instance) =>
    <String, dynamic>{
      'formid': instance.formId,
      'paymenturl': instance.paymentUrl,
      'errormsg': instance.errorMsg,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_redirect_applepay.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepositRedirectApplePay _$DepositRedirectApplePayFromJson(
    Map<String, dynamic> json) {
  return DepositRedirectApplePay()
    ..formId = json['formid'] as String
    ..paymentUrl = json['paymenturl'] as String
    ..errorMsg = json['errormsg'] as String;
}

Map<String, dynamic> _$DepositRedirectApplePayToJson(
        DepositRedirectApplePay instance) =>
    <String, dynamic>{
      'formid': instance.formId,
      'paymenturl': instance.paymentUrl,
      'errormsg': instance.errorMsg,
    };

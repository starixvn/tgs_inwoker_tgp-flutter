import 'package:json_annotation/json_annotation.dart';

part 'deposit_redirect_applepay.g.dart';

@JsonSerializable()
class DepositRedirectApplePay {
  DepositRedirectApplePay(this.formId, this.paymentUrl, this.errorMsg);

  @JsonKey(name: "formid")
  String? formId;
  @JsonKey(name: "paymenturl")
  String? paymentUrl;
  @JsonKey(name: "errormsg")
  String? errorMsg;

  factory DepositRedirectApplePay.fromJson(Map<String, dynamic> json) => _$DepositRedirectApplePayFromJson(json);

  Map<String, dynamic> toJson() => _$DepositRedirectApplePayToJson(this);
}

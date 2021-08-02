import 'package:json_annotation/json_annotation.dart';
part 'deposit_redirect.g.dart';

@JsonSerializable()

class DepositRedirect {
  DepositRedirect();

  @JsonKey(name: "formid")
  String formId;
  @JsonKey(name: "paymenturl")
  String paymentUrl;


  factory DepositRedirect.fromJson(Map<String, dynamic> json) => _$DepositRedirectFromJson(json);
  Map<String, dynamic> toJson() => _$DepositRedirectToJson(this);
}

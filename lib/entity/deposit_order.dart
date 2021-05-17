import 'package:tgp_flutter/entity/deposit_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'deposit_order.g.dart';

@JsonSerializable()

class DepositOrder {
  DepositOrder();

  @JsonKey(name: "methodname")
  String methodName;
  @JsonKey(name: "channelname")
  String channelName;
  double amount;
  @JsonKey(name: "bankname")
  String bankName;
  @JsonKey(name: "bankaccountname")
  String bankAccountName;
  @JsonKey(name: "bankaccount")

  String bankAccount;

  factory DepositOrder.fromJson(Map<String, dynamic> json) => _$DepositOrderFromJson(json);
  Map<String, dynamic> toJson() => _$DepositOrderToJson(this);
}
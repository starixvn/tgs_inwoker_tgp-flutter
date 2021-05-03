import 'package:tgp_flutter/entity/deposit_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'deposit_order.g.dart';

@JsonSerializable()

class DepositOrder {
  DepositOrder();

  String methodName;
  String channelName;
  double amount;
  String bankName;
  String bankAccountName;
  String bankAccount;

  factory DepositOrder.fromJson(Map<String, dynamic> json) => _$DepositOrderFromJson(json);
  Map<String, dynamic> toJson() => _$DepositOrderToJson(this);
}
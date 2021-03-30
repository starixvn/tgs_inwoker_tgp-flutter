import 'package:tgp_flutter/entity/deposit_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'deposit_order.g.dart';

@JsonSerializable()

class DepositOrder {
  DepositOrder();

  int id;
  String sn;
  @JsonKey(name: "order_time")
  String orderTime;
  String amount;

  factory DepositOrder.fromJson(Map<String, dynamic> json) => _$DepositOrderFromJson(json);
  Map<String, dynamic> toJson() => _$DepositOrderToJson(this);
}
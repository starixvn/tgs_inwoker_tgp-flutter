import 'package:tgp_flutter/entity/bank_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/entity/transfer_limit.dart';
part 'payment.g.dart';

@JsonSerializable()

class Payment {
  Payment();

  String id;
  @JsonKey(name: "banktype")
  BankType bankType;
  @JsonKey(name: "channelname")
  String channelName;
  @JsonKey(name: "transferlimit")
  TransferLimit transferLimit;
  @JsonKey(name: "paymentid")
  String paymentId;
  @JsonKey(name: "paymentcode")
  String paymentCode;
  @JsonKey(name: "methodid")
  String methodId;
  @JsonKey(name: "methodcode")
  String methodCode;
  @JsonKey(name: "displayorder")
  int order;

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}


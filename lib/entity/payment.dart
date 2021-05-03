import 'package:tgp_flutter/entity/payment_bank.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/entity/transfer_limit.dart';
part 'payment.g.dart';

@JsonSerializable()

class Payment {
  Payment();

  String id;
  String channelName;
  TransferLimit transferLimit;
  @JsonKey(name: "payment_id")
  String paymentId;
  String paymentCode;
  String methodId;
  String methodCode;

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}


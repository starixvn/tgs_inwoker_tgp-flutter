import 'package:tgp_flutter/entity/bank_type.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/entity/payment_qr_code.dart';
import 'package:tgp_flutter/entity/transfer_limit.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment {
  Payment(this.id, this.bankType, this.channelName, this.transferLimit, this.paymentId, this.paymentCode, this.methodId,
      this.methodCode, this.order);

  String? id;
  @JsonKey(name: "banktype")
  BankType? bankType;
  @JsonKey(name: "channelname")
  String? channelName;
  @JsonKey(name: "transferlimit")
  TransferLimit? transferLimit;
  @JsonKey(name: "paymentid")
  String? paymentId;
  @JsonKey(name: "paymentcode")
  String? paymentCode;
  @JsonKey(name: "methodid")
  String? methodId;
  @JsonKey(name: "methodcode")
  String? methodCode;
  @JsonKey(name: "displayorder")
  int? order;
  @JsonKey(name: "extended")
  PaymentQrCode? qrCode;

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}

import 'package:tgp_flutter/entity/bank_type.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/entity/transfer_limit.dart';
part 'payment_qr_code.g.dart';

@JsonSerializable()

class PaymentQrCode {
  PaymentQrCode();

  String? qrCode;
  String? qrCodeFileUrl;


  factory PaymentQrCode.fromJson(Map<String, dynamic> json) => _$PaymentQrCodeFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentQrCodeToJson(this);
}


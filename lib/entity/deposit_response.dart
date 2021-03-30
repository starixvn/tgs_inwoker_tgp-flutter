import 'package:tgp_flutter/entity/deposit_order.dart';
import 'package:tgp_flutter/entity/params.dart';
import 'package:json_annotation/json_annotation.dart';
part 'deposit_response.g.dart';

@JsonSerializable()

class DepositResponse {
  DepositResponse();

  @JsonKey(name: "payment_id")
  int paymentId;
  @JsonKey(name: "is_qrcode")
  int isQrcode;
  @JsonKey(name: "is_transfer")
  int isTransfer;
  dynamic url;
  String qrcode;
  Params params;
  DepositOrder order;
  @JsonKey(name: "expired_time")
  int expiredTime;

  factory DepositResponse.fromJson(Map<String, dynamic> json) => _$DepositResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DepositResponseToJson(this);
}
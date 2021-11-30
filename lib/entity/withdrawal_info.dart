import 'package:tgp_flutter/entity/bank_extended_info.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/entity/transfer_limit.dart';

import 'bank_type.dart';

part 'withdrawal_info.g.dart';

@JsonSerializable()
class WithdrawalInfo {
  WithdrawalInfo(this.id, this.bankType, this.channelId, this.channelName, this.channelCode, this.methodCode,
      this.methodId, this.paymentCode, this.paymentId, this.transferLimit, this.bankExtendedInfo);

  String id;
  @JsonKey(name: "banktype")
  BankType bankType;
  @JsonKey(name: "channelid")
  String channelId;
  @JsonKey(name: "channelname")
  String channelName;
  @JsonKey(name: "channelcode")
  String channelCode;
  @JsonKey(name: "methodcode")
  String methodCode;
  @JsonKey(name: "methodid")
  String methodId;
  @JsonKey(name: "paymentcode")
  String paymentCode;
  @JsonKey(name: "paymentid")
  String paymentId;
  @JsonKey(name: "transferlimit")
  TransferLimit transferLimit;
  @JsonKey(name: "extended")
  BankExtendedInfo bankExtendedInfo;

  factory WithdrawalInfo.fromJson(Map<String, dynamic> json) => _$WithdrawalInfoFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawalInfoToJson(this);
}

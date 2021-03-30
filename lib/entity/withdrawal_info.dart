import 'package:tgp_flutter/entity/bonus_limit.dart';
import 'package:json_annotation/json_annotation.dart';
part 'withdrawal_info.g.dart';

@JsonSerializable()

class WithdrawalInfo {
  WithdrawalInfo();

  String balance;
  @JsonKey(name: "limit_withdrawal")
  String limitWithdrawal;
  @JsonKey(name: "limit_turnover")
  String limitTurnover;
  @JsonKey(name: "can_withdrawal")
  String canWithdrawal;
  @JsonKey(name: "bonus_limit_withdrawal")
  String bonusLimitWithdrawal;
  @JsonKey(name: "bonus_limit_list")
  List<BonusLimit> bonusLimitList;


  factory WithdrawalInfo.fromJson(Map<String, dynamic> json) => _$WithdrawalInfoFromJson(json);
  Map<String, dynamic> toJson() => _$WithdrawalInfoToJson(this);
}
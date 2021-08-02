import 'package:json_annotation/json_annotation.dart';
part 'vip_progress.g.dart';
@JsonSerializable()

class VipProgress {
  VipProgress();

  int id;
  String title;
  @JsonKey(name: "upgrade_gift_amount")
  String upgradeGiftAmount;
  @JsonKey(name: "upgrade_gift_multiple")
  String upgrade_gift_multiple;
  @JsonKey(name: "birthday_gift_amount")
  String birthdayGiftAmount;
  @JsonKey(name: "birthday_gift_multiple")
  String birthdayGiftMultiple;
  @JsonKey(name: "topped_gift_amount")
  String toppedGiftAmount;
  @JsonKey(name: "topped_gift_multiple")
  String toppedGiftMultiple;
  @JsonKey(name: "deposit_bonus")
  String depositBonus;
  @JsonKey(name: "deposit_bonus_limit")
  String depositBonusLimit;
  @JsonKey(name: "deposit_bonus_multiple")
  String depositBonusMultiple;
  @JsonKey(name: "rescue_amount")
  String rescueAmount;
  @JsonKey(name: "rescue_amount_limit")
  String rescueAmountLimit;
  @JsonKey(name: "rescue_amount_multiple")
  String rescueAmountMultiple;
  @JsonKey(name: "free_withdrawal_num")
  int freeWithdrawalNum;

  factory VipProgress.fromJson(Map<String, dynamic> json) => _$VipProgressFromJson(json);
  Map<String, dynamic> toJson() => _$VipProgressToJson(this);
}
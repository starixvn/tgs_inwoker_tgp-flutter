// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vip_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VipProgress _$VipProgressFromJson(Map<String, dynamic> json) {
  return VipProgress()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..upgradeGiftAmount = json['upgrade_gift_amount'] as String
    ..upgrade_gift_multiple = json['upgrade_gift_multiple'] as String
    ..birthdayGiftAmount = json['birthday_gift_amount'] as String
    ..birthdayGiftMultiple = json['birthday_gift_multiple'] as String
    ..toppedGiftAmount = json['topped_gift_amount'] as String
    ..toppedGiftMultiple = json['topped_gift_multiple'] as String
    ..depositBonus = json['deposit_bonus'] as String
    ..depositBonusLimit = json['deposit_bonus_limit'] as String
    ..depositBonusMultiple = json['deposit_bonus_multiple'] as String
    ..rescueAmount = json['rescue_amount'] as String
    ..rescueAmountLimit = json['rescue_amount_limit'] as String
    ..rescueAmountMultiple = json['rescue_amount_multiple'] as String
    ..freeWithdrawalNum = json['free_withdrawal_num'] as int;
}

Map<String, dynamic> _$VipProgressToJson(VipProgress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'upgrade_gift_amount': instance.upgradeGiftAmount,
      'upgrade_gift_multiple': instance.upgrade_gift_multiple,
      'birthday_gift_amount': instance.birthdayGiftAmount,
      'birthday_gift_multiple': instance.birthdayGiftMultiple,
      'topped_gift_amount': instance.toppedGiftAmount,
      'topped_gift_multiple': instance.toppedGiftMultiple,
      'deposit_bonus': instance.depositBonus,
      'deposit_bonus_limit': instance.depositBonusLimit,
      'deposit_bonus_multiple': instance.depositBonusMultiple,
      'rescue_amount': instance.rescueAmount,
      'rescue_amount_limit': instance.rescueAmountLimit,
      'rescue_amount_multiple': instance.rescueAmountMultiple,
      'free_withdrawal_num': instance.freeWithdrawalNum,
    };

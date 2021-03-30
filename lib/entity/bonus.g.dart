// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bonus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bonus _$BonusFromJson(Map<String, dynamic> json) {
  return Bonus()
    ..boreId = json['bore_id'] as int
    ..bonusId = json['bonus_id'] as int
    ..typeId = json['type_id'] == null
        ? null
        : BonusCategory.fromJson(json['type_id'] as Map<String, dynamic>)
    ..routine = json['routine'] as int
    ..amount = json['amount'] as String
    ..turnoverNum = json['turnover_num'] as String
    ..imageId = json['image_id'] as int
    ..createTime = json['create_time'] as String
    ..startTime = json['start_time'] as String
    ..endTime = json['end_time'] as String
    ..expiredTime = json['expired_time'] as String
    ..turnoverPlatformId = json['turnover_platform_id'] as int
    ..turnoverPlatformTypeId = json['turnover_platform_type_id'] as int
    ..turnoverThirdpartyId = json['turnover_thirdparty_id'] as int
    ..turnoverThirdpartyParentId = json['turnover_thirdparty_parent_id'] as int
    ..passAccount = json['pass_account'] as int
    ..passEmail = json['pass_email'] as int
    ..passPhone = json['pass_phone'] as int
    ..deposited = json['deposited'] as String
    ..title = json['title'] as String
    ..remark = json['remark'] as String
    ..calcStartTime = json['calc_start_time'] as int
    ..calcEndTime = json['calc_end_time'] as int
    ..depositFrom = json['deposit_from'] as int
    ..depositTo = json['deposit_to'] as int
    ..turnoverFrom = json['turnover_from'] as int
    ..turnoverTo = json['turnover_to'] as int
    ..currentDeposit = json['current_deposit'] as String
    ..currentTurnover = json['current_turnover'] as String
    ..checkTurnover = json['check_turnover'] as bool
    ..rateTurnover = json['rate_turnover'] as int
    ..checkDeposit = json['check_deposited'] as bool
    ..rateDeposit = json['rate_deposit'] as int
    ..checkPassAccount = json['check_pass_account'] as bool
    ..checkPassEmail = json['check_pass_email'] as bool
    ..checkPassPhone = json['check_pass_phone'] as bool
    ..showBtn = json['show_btn'] as int
    ..childExist = json['child_exist'] as int
    ..imageUrl = json['image_url'] as String
    ..turnoverLimit = json['turnover_limit'] as String
    ..day = json['day'] as String;
}

Map<String, dynamic> _$BonusToJson(Bonus instance) => <String, dynamic>{
      'bore_id': instance.boreId,
      'bonus_id': instance.bonusId,
      'type_id': instance.typeId,
      'routine': instance.routine,
      'amount': instance.amount,
      'turnover_num': instance.turnoverNum,
      'image_id': instance.imageId,
      'create_time': instance.createTime,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'expired_time': instance.expiredTime,
      'turnover_platform_id': instance.turnoverPlatformId,
      'turnover_platform_type_id': instance.turnoverPlatformTypeId,
      'turnover_thirdparty_id': instance.turnoverThirdpartyId,
      'turnover_thirdparty_parent_id': instance.turnoverThirdpartyParentId,
      'pass_account': instance.passAccount,
      'pass_email': instance.passEmail,
      'pass_phone': instance.passPhone,
      'deposited': instance.deposited,
      'title': instance.title,
      'remark': instance.remark,
      'calc_start_time': instance.calcStartTime,
      'calc_end_time': instance.calcEndTime,
      'deposit_from': instance.depositFrom,
      'deposit_to': instance.depositTo,
      'turnover_from': instance.turnoverFrom,
      'turnover_to': instance.turnoverTo,
      'current_deposit': instance.currentDeposit,
      'current_turnover': instance.currentTurnover,
      'check_turnover': instance.checkTurnover,
      'rate_turnover': instance.rateTurnover,
      'check_deposited': instance.checkDeposit,
      'rate_deposit': instance.rateDeposit,
      'check_pass_account': instance.checkPassAccount,
      'check_pass_email': instance.checkPassEmail,
      'check_pass_phone': instance.checkPassPhone,
      'show_btn': instance.showBtn,
      'child_exist': instance.childExist,
      'image_url': instance.imageUrl,
      'turnover_limit': instance.turnoverLimit,
      'day': instance.day,
    };

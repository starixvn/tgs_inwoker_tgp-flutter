// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_bonus_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepositBonusGroup _$DepositBonusGroupFromJson(Map<String, dynamic> json) {
  return DepositBonusGroup(
    json['depositBonus'] == null
        ? null
        : DepositBonus.fromJson(json['depositBonus'] as Map<String, dynamic>),
    (json['child'] as List)
        ?.map((e) =>
            e == null ? null : DepositBonus.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DepositBonusGroupToJson(DepositBonusGroup instance) =>
    <String, dynamic>{
      'depositBonus': instance.depositBonus,
      'child': instance.child,
    };

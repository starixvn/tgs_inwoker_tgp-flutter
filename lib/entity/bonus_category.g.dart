// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bonus_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BonusCategory _$BonusCategoryFromJson(Map<String, dynamic> json) {
  return BonusCategory()
    ..boreId = json['bore_id'] as int
    ..bonusId = json['bonus_id'] as int
    ..typeId = json['type_id'] == null
        ? null
        : BonusCategory.fromJson(json['type_id'] as Map<String, dynamic>)
    ..routine = json['routine'] as int
    ..buffer = json['buffer'] as String;
}

Map<String, dynamic> _$BonusCategoryToJson(BonusCategory instance) =>
    <String, dynamic>{
      'bore_id': instance.boreId,
      'bonus_id': instance.bonusId,
      'type_id': instance.typeId,
      'routine': instance.routine,
      'buffer': instance.buffer,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promotion _$PromotionFromJson(Map<String, dynamic> json) {
  return Promotion()
    ..isHot = json['is_hot'] as int
    ..typeId = json['type_id'] as int
    ..imageUrl = json['m_image_url'] as String;
}

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
      'is_hot': instance.isHot,
      'type_id': instance.typeId,
      'm_image_url': instance.imageUrl,
    };

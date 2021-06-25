// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_localization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionLocalization _$PromotionLocalizationFromJson(
    Map<String, dynamic> json) {
  return PromotionLocalization()
    ..name = json['name'] as String
    ..subSubject = json['subSubject'] as String
    ..content = json['content'] as String
    ..mobileBanner = json['mobileBanner'] as String;
}

Map<String, dynamic> _$PromotionLocalizationToJson(
        PromotionLocalization instance) =>
    <String, dynamic>{
      'name': instance.name,
      'subSubject': instance.subSubject,
      'content': instance.content,
      'mobileBanner': instance.mobileBanner,
    };

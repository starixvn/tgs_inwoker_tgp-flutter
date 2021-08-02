// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Localization _$LocalizationFromJson(Map<String, dynamic> json) {
  return Localization()
    ..name = json['name'] as String
    ..subSubject = json['subSubject'] as String
    ..content = json['content'] as String
    ..mobileBanner = json['mobileBanner'] as String;
}

Map<String, dynamic> _$LocalizationToJson(Localization instance) =>
    <String, dynamic>{
      'name': instance.name,
      'subSubject': instance.subSubject,
      'content': instance.content,
      'mobileBanner': instance.mobileBanner,
    };

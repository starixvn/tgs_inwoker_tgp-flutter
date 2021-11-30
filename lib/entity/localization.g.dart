// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Localization _$LocalizationFromJson(Map<String, dynamic> json) => Localization(
      json['name'] as String?,
      json['subSubject'] as String?,
      json['content'] as String?,
      json['mobileBanner'] as String?,
    )..subject = json['subject'] as String?;

Map<String, dynamic> _$LocalizationToJson(Localization instance) =>
    <String, dynamic>{
      'name': instance.name,
      'subSubject': instance.subSubject,
      'content': instance.content,
      'mobileBanner': instance.mobileBanner,
      'subject': instance.subject,
    };

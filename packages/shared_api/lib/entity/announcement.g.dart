// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Announcement _$AnnouncementFromJson(Map<String, dynamic> json) {
  return Announcement()
    ..subject = json['subject'] as String
    ..content = json['content'] as String
    ..from = json['from'] as int
    ..to = json['to'] as int
    ..localization = json['localization'] == null
        ? null
        : Localization.fromJson(json['localization'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AnnouncementToJson(Announcement instance) =>
    <String, dynamic>{
      'subject': instance.subject,
      'content': instance.content,
      'from': instance.from,
      'to': instance.to,
      'localization': instance.localization,
    };

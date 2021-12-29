// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Announcement _$AnnouncementFromJson(Map<String, dynamic> json) => Announcement(
      json['subject'] as String?,
      json['content'] as String?,
      json['from'] as int?,
      json['to'] as int?,
      json['localization'] == null
          ? null
          : Localization.fromJson(json['localization'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnnouncementToJson(Announcement instance) =>
    <String, dynamic>{
      'subject': instance.subject,
      'content': instance.content,
      'from': instance.from,
      'to': instance.to,
      'localization': instance.localization,
    };

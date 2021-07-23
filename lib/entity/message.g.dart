// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message()
    ..id = json['id'] as String
    ..createdOn = json['createon'] as String
    ..content = json['content'] as String
    ..subject = json['subject'] as String
    ..isRead = json['isread'] as bool
    ..localization = json['localization'] == null
        ? null
        : Localization.fromJson(json['localization'] as Map<String, dynamic>);
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'createon': instance.createdOn,
      'content': instance.content,
      'subject': instance.subject,
      'isread': instance.isRead,
      'localization': instance.localization,
    };

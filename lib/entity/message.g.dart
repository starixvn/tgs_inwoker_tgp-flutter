// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      json['id'] as String?,
      json['createon'] as String?,
      json['content'] as String?,
      json['subject'] as String?,
      json['isread'] as bool?,
      json['localization'] == null
          ? null
          : Localization.fromJson(json['localization'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'createon': instance.createdOn,
      'content': instance.content,
      'subject': instance.subject,
      'isread': instance.isRead,
      'localization': instance.localization,
    };

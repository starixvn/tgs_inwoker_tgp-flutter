// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..content = json['content'] as String
    ..createdTime = json['created_time'] as String
    ..readId = json['read_id'] as int
    ..intIsRead = json['is_read'] as int
    ..isAdminSend = json['is_admin_send'] as int;
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'created_time': instance.createdTime,
      'read_id': instance.readId,
      'is_read': instance.intIsRead,
      'is_admin_send': instance.isAdminSend,
    };

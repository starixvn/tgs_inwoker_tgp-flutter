// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveChat _$LiveChatFromJson(Map<String, dynamic> json) {
  return LiveChat()
    ..name = json['name'] as String
    ..setting = json['setting'] == null
        ? null
        : Url.fromJson(json['setting'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LiveChatToJson(LiveChat instance) => <String, dynamic>{
      'name': instance.name,
      'setting': instance.setting,
    };

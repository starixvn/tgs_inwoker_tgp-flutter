// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageResponse _$MessageResponseFromJson(Map<String, dynamic> json) {
  return MessageResponse(
    json['err'] as int,
    json['errmsg'] as String,
    json['totalcount'] as int,
    (json['items'] as List)
        ?.map((e) =>
            e == null ? null : Message.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MessageResponseToJson(MessageResponse instance) =>
    <String, dynamic>{
      'err': instance.code,
      'errmsg': instance.msg,
      'totalcount': instance.totalCount,
      'items': instance.items,
    };

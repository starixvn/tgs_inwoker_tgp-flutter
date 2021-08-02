// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_message_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMessageListResponse _$GetMessageListResponseFromJson(
    Map<String, dynamic> json) {
  return GetMessageListResponse(
    json['total'] as int,
    json['page_size'] as int,
    (json['datas'] as List)
        ?.map((e) =>
            e == null ? null : Message.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GetMessageListResponseToJson(
        GetMessageListResponse instance) =>
    <String, dynamic>{
      'total': instance.totalCount,
      'page_size': instance.pageSize,
      'datas': instance.messageList,
    };

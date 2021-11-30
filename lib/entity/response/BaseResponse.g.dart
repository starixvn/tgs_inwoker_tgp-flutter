// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BaseResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse(
      json['err'] as int?,
      json['data'],
      json['errmsg'] as String?,
      json['errmsgid'] as String?,
    )..success = json['success'] as bool?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'err': instance.error,
      'data': instance.data,
      'errmsg': instance.msg,
      'success': instance.success,
      'errmsgid': instance.errorMsgId,
    };

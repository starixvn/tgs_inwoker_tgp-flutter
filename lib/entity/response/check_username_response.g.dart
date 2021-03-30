// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_username_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckUsernameResponse _$CheckUsernameResponseFromJson(
    Map<String, dynamic> json) {
  return CheckUsernameResponse(
    json['err'] as int,
    json['errmsg'] as String,
    json['isexist'] as bool,
  );
}

Map<String, dynamic> _$CheckUsernameResponseToJson(
        CheckUsernameResponse instance) =>
    <String, dynamic>{
      'err': instance.code,
      'errmsg': instance.msg,
      'isexist': instance.isExist,
    };

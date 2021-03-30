// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) {
  return RegisterResponse(
    json['err'] as int,
    json['errmsg'] as String,
    json['uid'] as String,
    json['isnew'] as bool,
  );
}

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'err': instance.code,
      'errmsg': instance.msg,
      'uid': instance.uid,
      'isnew': instance.isNew,
    };

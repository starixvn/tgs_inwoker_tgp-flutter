// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditPasswordResponse _$EditPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    EditPasswordResponse(
      json['playercode'] as String,
      json['updatetime'] as String,
    );

Map<String, dynamic> _$EditPasswordResponseToJson(
        EditPasswordResponse instance) =>
    <String, dynamic>{
      'playercode': instance.playerCode,
      'updatetime': instance.updateTime,
    };

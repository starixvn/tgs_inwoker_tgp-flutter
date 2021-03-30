// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecurityQuestion _$SecurityQuestionFromJson(Map<String, dynamic> json) {
  return SecurityQuestion()
    ..securityQuestionId = json['id'] as int
    ..securityQuestionName = json['title'] as String;
}

Map<String, dynamic> _$SecurityQuestionToJson(SecurityQuestion instance) =>
    <String, dynamic>{
      'id': instance.securityQuestionId,
      'title': instance.securityQuestionName,
    };

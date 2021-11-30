// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      json['username'] as String,
      json['realname'] as String?,
      json['phone'] as String?,
      json['email'] as String?,
      json['qq'] as String?,
      json['wechat'] as String?,
      json['issetpaypassword'] as bool,
      json['identityauthentication'] as bool,
      json['viplevel'] as int,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'username': instance.username,
      'realname': instance.realname,
      'phone': instance.phone,
      'email': instance.email,
      'qq': instance.qq,
      'wechat': instance.wechat,
      'issetpaypassword': instance.isSetPayPassword,
      'identityauthentication': instance.identityAuthentication,
      'viplevel': instance.vipLevel,
    };

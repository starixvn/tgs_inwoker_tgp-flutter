// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return UserProfile()
    ..username = json['username'] as String
    ..realname = json['realname'] as String
    ..phone = json['phone'] as String
    ..email = json['email'] as String
    ..qq = json['qq'] as String
    ..wechat = json['wechat'] as String
    ..isSetPayPassword = json['issetpaypassword'] as bool
    ..identityAuthentication = json['identityauthentication'] as bool;
}

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
    };

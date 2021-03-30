// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_vip_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileVIPProgress _$ProfileVIPProgressFromJson(Map<String, dynamic> json) {
  return ProfileVIPProgress()
    ..id = json['id'] as int
    ..currTitle = json['curr_title'] as String
    ..currPoint = json['curr_owned_point'] as String
    ..nextTitle = json['next_title'] as String
    ..nextPoint = json['next_point'] as String
    ..requirePoint = json['require_point'] as String
    ..vipProgressBar = json['vip_progress_bar'] as int;
}

Map<String, dynamic> _$ProfileVIPProgressToJson(ProfileVIPProgress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'curr_title': instance.currTitle,
      'curr_owned_point': instance.currPoint,
      'next_title': instance.nextTitle,
      'next_point': instance.nextPoint,
      'require_point': instance.requirePoint,
      'vip_progress_bar': instance.vipProgressBar,
    };

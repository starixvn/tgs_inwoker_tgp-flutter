// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vip_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VipDetail _$VipDetailFromJson(Map<String, dynamic> json) {
  return VipDetail()
    ..member = json['member'] as String
    ..nextVipTitle = json['next_vip_title'] as String
    ..ownedPoint = json['owned_point'] as String
    ..nextPoint = json['next_point'] as String
    ..requirePoint = json['require_point'] as String
    ..vipProgressBar = json['vip_progress_bar'] as int
    ..currVip = json['curr_vip'] == null
        ? null
        : VipProgress.fromJson(json['curr_vip'] as Map<String, dynamic>)
    ..nextVip = json['next_vip'] == null
        ? null
        : VipProgress.fromJson(json['next_vip'] as Map<String, dynamic>);
}

Map<String, dynamic> _$VipDetailToJson(VipDetail instance) => <String, dynamic>{
      'member': instance.member,
      'next_vip_title': instance.nextVipTitle,
      'owned_point': instance.ownedPoint,
      'next_point': instance.nextPoint,
      'require_point': instance.requirePoint,
      'vip_progress_bar': instance.vipProgressBar,
      'curr_vip': instance.currVip,
      'next_vip': instance.nextVip,
    };

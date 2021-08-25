// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBanner _$HomeBannerFromJson(Map<String, dynamic> json) {
  return HomeBanner()
    ..id = json['id'] as String
    ..mobileUrl = json['mobileurl'] as String
    ..title = json['title'] as String;
}

Map<String, dynamic> _$HomeBannerToJson(HomeBanner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mobileurl': instance.mobileUrl,
      'title': instance.title,
    };

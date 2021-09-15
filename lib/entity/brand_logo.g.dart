// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_logo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandLogo _$BrandLogoFromJson(Map<String, dynamic> json) {
  return BrandLogo()
    ..id = json['brandId'] as String
    ..mobileUrl = json['mobileLogoUrl'] as String;
}

Map<String, dynamic> _$BrandLogoToJson(BrandLogo instance) => <String, dynamic>{
      'brandId': instance.id,
      'mobileLogoUrl': instance.mobileUrl,
    };

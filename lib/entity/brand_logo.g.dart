// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_logo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandLogo _$BrandLogoFromJson(Map<String, dynamic> json) => BrandLogo(
      json['brandId'] as String?,
      json['mobileLogoUrl'] as String?,
      json['hasInvitationCode'] as bool?,
    );

Map<String, dynamic> _$BrandLogoToJson(BrandLogo instance) => <String, dynamic>{
      'brandId': instance.id,
      'mobileLogoUrl': instance.mobileUrl,
      'hasInvitationCode': instance.hasInvitationCode,
    };

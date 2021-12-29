// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_communication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandCommunication _$BrandCommunicationFromJson(Map<String, dynamic> json) =>
    BrandCommunication(
      json['type'] as String?,
      json['phone'] as String?,
      json['appid'] as String?,
      json['qrcodeurl'] as String?,
    );

Map<String, dynamic> _$BrandCommunicationToJson(BrandCommunication instance) =>
    <String, dynamic>{
      'type': instance.type,
      'phone': instance.phone,
      'appid': instance.appId,
      'qrcodeurl': instance.qrCodeUrl,
    };

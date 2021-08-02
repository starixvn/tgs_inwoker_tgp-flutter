// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_communication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandCommunication _$BrandCommunicationFromJson(Map<String, dynamic> json) {
  return BrandCommunication()
    ..type = json['type'] as String
    ..phone = json['phone'] as String
    ..appId = json['appid'] as String
    ..qrCodeUrl = json['qrcodeurl'] as String;
}

Map<String, dynamic> _$BrandCommunicationToJson(BrandCommunication instance) =>
    <String, dynamic>{
      'type': instance.type,
      'phone': instance.phone,
      'appid': instance.appId,
      'qrcodeurl': instance.qrCodeUrl,
    };

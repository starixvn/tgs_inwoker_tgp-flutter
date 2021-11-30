// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_qr_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentQrCode _$PaymentQrCodeFromJson(Map<String, dynamic> json) =>
    PaymentQrCode()
      ..qrCode = json['qrCode'] as String?
      ..qrCodeFileUrl = json['qrCodeFileUrl'] as String?;

Map<String, dynamic> _$PaymentQrCodeToJson(PaymentQrCode instance) =>
    <String, dynamic>{
      'qrCode': instance.qrCode,
      'qrCodeFileUrl': instance.qrCodeFileUrl,
    };

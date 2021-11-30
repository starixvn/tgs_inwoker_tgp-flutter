// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_extended_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankExtendedInfo _$BankExtendedInfoFromJson(Map<String, dynamic> json) =>
    BankExtendedInfo(
      json['channel'] as String?,
      json['systemId'] as String?,
      json['systemKey'] as String?,
      json['channelCurrency'] as String?,
    );

Map<String, dynamic> _$BankExtendedInfoToJson(BankExtendedInfo instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'systemId': instance.systemId,
      'systemKey': instance.systemKey,
      'channelCurrency': instance.channelCurrency,
    };

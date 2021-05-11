// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_extended_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankExtendedInfo _$BankExtendedInfoFromJson(Map<String, dynamic> json) {
  return BankExtendedInfo()
    ..channel = json['channel'] as String
    ..systemId = json['systemId'] as String
    ..systemKey = json['systemKey'] as String
    ..channelCurrency = json['channelCurrency'] as String;
}

Map<String, dynamic> _$BankExtendedInfoToJson(BankExtendedInfo instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'systemId': instance.systemId,
      'systemKey': instance.systemKey,
      'channelCurrency': instance.channelCurrency,
    };

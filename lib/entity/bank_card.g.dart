// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankCard _$BankCardFromJson(Map<String, dynamic> json) => BankCard(
      json['id'] as String,
      json['paymentchannelid'] as String,
      $enumDecode(_$BankTypeEnumMap, json['banktype']),
      BankDetail.fromJson(json['detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BankCardToJson(BankCard instance) => <String, dynamic>{
      'id': instance.id,
      'paymentchannelid': instance.paymentChannelId,
      'banktype': _$BankTypeEnumMap[instance.bankType],
      'detail': instance.bankDetail,
    };

const _$BankTypeEnumMap = {
  BankType.BANK: 'Bank',
  BankType.CRYPTO: 'Crypto',
  BankType.THIRD_PARTY: 'ThirdParty',
  BankType.FPS: 'FPS',
};

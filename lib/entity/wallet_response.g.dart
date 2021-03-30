// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletResponse _$WalletResponseFromJson(Map<String, dynamic> json) {
  return WalletResponse()
    ..walletList = (json['thirdpartys'] as List)
        ?.map((e) =>
            e == null ? null : Wallet.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$WalletResponseToJson(WalletResponse instance) =>
    <String, dynamic>{
      'thirdpartys': instance.walletList,
    };

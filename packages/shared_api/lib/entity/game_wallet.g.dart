// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameWallet _$GameWalletFromJson(Map<String, dynamic> json) {
  return GameWallet()..balance = (json['balance'] as num)?.toDouble();
}

Map<String, dynamic> _$GameWalletToJson(GameWallet instance) =>
    <String, dynamic>{
      'balance': instance.balance,
    };

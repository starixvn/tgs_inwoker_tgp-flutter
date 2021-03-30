// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) {
  return Wallet()
    ..id = json['id'] as int
    ..parentId = json['parent_id'] as int
    ..code = json['code'] as String
    ..name = json['name'] as String
    ..type = json['type'] as int
    ..pnlRatio = json['pnl_ratio'] as String
    ..purseType = json['purse_type'] as int
    ..status = json['status'] as int
    ..shortName = json['short_name'] as String
    ..maintenance = json['maintenance'] as int
    ..oldId = json['old_id'] as int
    ..timezone = json['timezone'] as int
    ..balance = json['balance']
    ..moneyLimit = json['money_limit']
    ..moneyLimitStatus = json['moneyLimitStatus'] as bool;
}

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'id': instance.id,
      'parent_id': instance.parentId,
      'code': instance.code,
      'name': instance.name,
      'type': instance.type,
      'pnl_ratio': instance.pnlRatio,
      'purse_type': instance.purseType,
      'status': instance.status,
      'short_name': instance.shortName,
      'maintenance': instance.maintenance,
      'old_id': instance.oldId,
      'timezone': instance.timezone,
      'balance': instance.balance,
      'money_limit': instance.moneyLimit,
      'moneyLimitStatus': instance.moneyLimitStatus,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promotion _$PromotionFromJson(Map<String, dynamic> json) {
  return Promotion()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..from = json['from'] as String
    ..to = json['to'] as String
    ..status = json['status'] as int
    ..promotionType = json['promotionType'] as String
    ..bonusAmountLimit = (json['bonusAmountLimit'] as num)?.toDouble()
    ..amountUsed = (json['amountUsed'] as num)?.toDouble()
    ..unlimited = json['unlimited'] as bool
    ..gameType = json['gameType'] as int
    ..percentage = (json['percentage'] as num)?.toDouble()
    ..totalAmountLimit = (json['totalAmountLimit'] as num)?.toDouble()
    ..turnoverMultiple = (json['turnoverMultiple'] as num)?.toDouble()
    ..gameProviderIds =
        (json['gameProviderIds'] as List)?.map((e) => e as String)?.toList()
    ..vipLevels = (json['vipLevels'] as List)?.map((e) => e as int)?.toList()
    ..createdOn = json['createdOn'] as String
    ..updatedOn = json['updatedOn'] as String
    ..createdByUsername = json['createdByUsername'] as String
    ..updatedByUsername = json['updatedByUsername'] as String
    ..localization = json['localization'] == null
        ? null
        : Localization.fromJson(json['localization'] as Map<String, dynamic>)
    ..mobileBanner = json['mobileBanner'] as String;
}

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'from': instance.from,
      'to': instance.to,
      'status': instance.status,
      'promotionType': instance.promotionType,
      'bonusAmountLimit': instance.bonusAmountLimit,
      'amountUsed': instance.amountUsed,
      'unlimited': instance.unlimited,
      'gameType': instance.gameType,
      'percentage': instance.percentage,
      'totalAmountLimit': instance.totalAmountLimit,
      'turnoverMultiple': instance.turnoverMultiple,
      'gameProviderIds': instance.gameProviderIds,
      'vipLevels': instance.vipLevels,
      'createdOn': instance.createdOn,
      'updatedOn': instance.updatedOn,
      'createdByUsername': instance.createdByUsername,
      'updatedByUsername': instance.updatedByUsername,
      'localization': instance.localization,
      'mobileBanner': instance.mobileBanner,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'third_party.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThirdParty _$ThirdPartyFromJson(Map<String, dynamic> json) {
  return ThirdParty(
    json['id'] as int,
    json['parent_id'] as int,
    _$enumDecodeNullable(_$TransactionThirdPartyTypeEnumMap, json['type']),
    json['purse_type'] as int,
    json['status'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$ThirdPartyToJson(ThirdParty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parent_id': instance.parentId,
      'type': _$TransactionThirdPartyTypeEnumMap[instance.type],
      'purse_type': instance.purseType,
      'status': instance.status,
      'name': instance.name,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$TransactionThirdPartyTypeEnumMap = {
  TransactionThirdPartyType.ALL: 0,
  TransactionThirdPartyType.SPORT: 1,
  TransactionThirdPartyType.LOTTERY: 2,
  TransactionThirdPartyType.LIVEGAME: 3,
  TransactionThirdPartyType.QIPAI: 4,
  TransactionThirdPartyType.SLOTGAME: 5,
};

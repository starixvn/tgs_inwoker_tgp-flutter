// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountTransaction _$AccountTransactionFromJson(Map<String, dynamic> json) {
  return AccountTransaction()
    ..id = json['id'] as String
    ..createdOn = json['createdon'] as String
    ..updatedOn = json['updatedOn'] as String
    ..status = _$enumDecodeNullable(_$StatusEnumMap, json['status'])
    ..amount = (json['amount'] as num)?.toDouble()
    ..canUploadCerts = json['canuploadcerts'] as bool;
}

Map<String, dynamic> _$AccountTransactionToJson(AccountTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdon': instance.createdOn,
      'updatedOn': instance.updatedOn,
      'status': _$StatusEnumMap[instance.status],
      'amount': instance.amount,
      'canuploadcerts': instance.canUploadCerts,
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

const _$StatusEnumMap = {
  Status.All: 'All',
  Status.WaitingPayment: 1,
  Status.Review: 2,
  Status.Approved: 3,
  Status.Rejected: 4,
};

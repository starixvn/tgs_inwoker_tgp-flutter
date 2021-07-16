// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionResponse<T> _$TransactionResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object json) fromJsonT,
) {
  return TransactionResponse<T>(
    json['totalCount'] as int,
    (json['items'] as List)?.map(fromJsonT)?.toList(),
  );
}

Map<String, dynamic> _$TransactionResponseToJson<T>(
  TransactionResponse<T> instance,
  Object Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'items': instance.items?.map(toJsonT)?.toList(),
    };

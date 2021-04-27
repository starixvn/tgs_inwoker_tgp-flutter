// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTransactionResponse<T> _$GetTransactionResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object json) fromJsonT,
) {
  return GetTransactionResponse<T>(
    (json['errors'] as List)?.map((e) => e as String)?.toList(),
    json['message'] as String,
    json['valid'] as bool,
    json['totalCount'] as int,
    (json['items'] as List)?.map(fromJsonT)?.toList(),
  );
}

Map<String, dynamic> _$GetTransactionResponseToJson<T>(
  GetTransactionResponse<T> instance,
  Object Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'errors': instance.errors,
      'valid': instance.valid,
      'message': instance.msg,
      'totalCount': instance.totalCount,
      'items': instance.items?.map(toJsonT)?.toList(),
    };

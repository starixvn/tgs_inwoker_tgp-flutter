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
    json['total'] as int,
    json['page_size'] as int,
    (json['datas'] as List)?.map(fromJsonT)?.toList(),
  );
}

Map<String, dynamic> _$GetTransactionResponseToJson<T>(
  GetTransactionResponse<T> instance,
  Object Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'total': instance.total,
      'page_size': instance.pageSize,
      'datas': instance.transactions?.map(toJsonT)?.toList(),
    };

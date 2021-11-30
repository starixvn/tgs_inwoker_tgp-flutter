// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_limit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferLimit _$TransferLimitFromJson(Map<String, dynamic> json) =>
    TransferLimit(
      (json['from'] as num).toDouble(),
      (json['to'] as num).toDouble(),
    );

Map<String, dynamic> _$TransferLimitToJson(TransferLimit instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
    };

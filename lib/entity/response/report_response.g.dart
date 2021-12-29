// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportResponse<T> _$ReportResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ReportResponse<T>(
      json['totalCount'] as int?,
      (json['items'] as List<dynamic>?)?.map(fromJsonT).toList(),
    );

Map<String, dynamic> _$ReportResponseToJson<T>(
  ReportResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'items': instance.items?.map(toJsonT).toList(),
    };

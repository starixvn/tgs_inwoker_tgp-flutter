// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_response2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportResponse2<T> _$ReportResponse2FromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ReportResponse2<T>(
      json['totalcount'] as int?,
      (json['items'] as List<dynamic>?)?.map(fromJsonT).toList(),
    );

Map<String, dynamic> _$ReportResponse2ToJson<T>(
  ReportResponse2<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'totalcount': instance.totalCount,
      'items': instance.items?.map(toJsonT).toList(),
    };

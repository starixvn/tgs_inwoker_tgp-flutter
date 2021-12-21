// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferReport _$TransferReportFromJson(Map<String, dynamic> json) =>
    TransferReport(
      json['from'] as String?,
      json['to'] as String?,
      (json['amount'] as num?)?.toDouble(),
      json['balancetime'] as String?,
    );

Map<String, dynamic> _$TransferReportToJson(TransferReport instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'amount': instance.amount,
      'balancetime': instance.balanceTime,
    };

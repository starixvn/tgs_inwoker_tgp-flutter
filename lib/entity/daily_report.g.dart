// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyReport _$DailyReportFromJson(Map<String, dynamic> json) => DailyReport(
      json['bet_time'] as String,
      json['bet_amount'],
      json['win_loss'],
      json['turnover'],
    );

Map<String, dynamic> _$DailyReportToJson(DailyReport instance) =>
    <String, dynamic>{
      'bet_time': instance.betTime,
      'bet_amount': instance.betAmount,
      'win_loss': instance.winLoss,
      'turnover': instance.turnover,
    };

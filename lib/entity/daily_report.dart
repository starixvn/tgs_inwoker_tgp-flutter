import 'package:json_annotation/json_annotation.dart';

part 'daily_report.g.dart';

@JsonSerializable()
class DailyReport {
  DailyReport(this.betTime, this.betAmount, this.winLoss, this.turnover);

  @JsonKey(name: "bet_time")
  String? betTime;
  @JsonKey(name: "bet_amount")
  double? betAmount;
  @JsonKey(name: "win_loss")
  double? winLoss;
  @JsonKey(name: "turnover")
  double? turnover;

  factory DailyReport.fromJson(Map<String, dynamic> json) => _$DailyReportFromJson(json);

  Map<String, dynamic> toJson() => _$DailyReportToJson(this);
}

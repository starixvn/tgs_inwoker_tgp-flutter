import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/entity/status.dart';

part 'transfer_report.g.dart';

@JsonSerializable()
class TransferReport {
  TransferReport(this.from, this.to, this.amount, this.balanceTime);

  String from;
  String to;
  double amount;
  @JsonKey(name: 'balancetime')
  String balanceTime;

  factory TransferReport.fromJson(Map<String, dynamic> json) => _$TransferReportFromJson(json);

  Map<String, dynamic> toJson() => _$TransferReportToJson(this);
}

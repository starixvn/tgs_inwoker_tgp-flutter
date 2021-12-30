import 'package:tgp_flutter/entity/bank_type.dart';

import 'package:json_annotation/json_annotation.dart';

part 'account_report.g.dart';

@JsonSerializable()
class AccountReport {
  AccountReport(
      this.id, this.createdOn, this.gameProviderName, this.betAmount, this.validBetAmount, this.winLoss, this.gameName);

  String? id;
  String? createdOn;
  String? gameProviderName;
  double? betAmount;
  double? validBetAmount;
  double? winLoss;
  String? gameName;

  factory AccountReport.fromJson(Map<String, dynamic> json) => _$AccountReportFromJson(json);

  Map<String, dynamic> toJson() => _$AccountReportToJson(this);
}

import 'package:tgp_flutter/entity/bank_type.dart';

import 'package:json_annotation/json_annotation.dart';

part 'promotion_report.g.dart';

@JsonSerializable()
class PromotionReport{
  PromotionReport(
    this.joinedOn,
    this.promotionName,
  );

  String? joinedOn;
  String? promotionName;

  factory PromotionReport.fromJson(Map<String, dynamic> json) => _$PromotionReportFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionReportToJson(this);
}

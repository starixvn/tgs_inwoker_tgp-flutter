import 'package:json_annotation/json_annotation.dart';
part 'deposit_bonus.g.dart';

@JsonSerializable()

class DepositBonus {
  DepositBonus();

  @JsonKey(name: "bosp_id")
  int bospId;
  @JsonKey(name: "bosp_title")
  String bospTitle;
  @JsonKey(name: "bonus_id")
  int bonusId;
  @JsonKey(name: "turnover_multiple")
  String turnoverMultiple;
  String title;
  String remark;
  @JsonKey(name: "start_time")
  String startTime;
  @JsonKey(name: "end_time")
  String endTime;
  double bonus;
  double turnover;
  @JsonKey(name: "turnover_limit")
  String turnoverLimit;

  factory DepositBonus.fromJson(Map<String, dynamic> json) => _$DepositBonusFromJson(json);
  Map<String, dynamic> toJson() => _$DepositBonusToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
part 'daily_transaction.g.dart';

@JsonSerializable()

class DailyTransaction {
  DailyTransaction();

  @JsonKey(name: "bet_time")
  String betTime;
  @JsonKey(name: "bet_amount")
  dynamic betAmount;
  @JsonKey(name: "win_loss")
  dynamic winLoss;
  @JsonKey(name: "turnover")
  dynamic turnover;

  factory DailyTransaction.fromJson(Map<String, dynamic> json) => _$DailyTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$DailyTransactionToJson(this);
}

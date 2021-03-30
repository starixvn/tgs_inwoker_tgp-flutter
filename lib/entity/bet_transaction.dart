import 'package:json_annotation/json_annotation.dart';
part 'bet_transaction.g.dart';

@JsonSerializable()

class BetTransaction {
  BetTransaction();

  @JsonKey(name: "bet_id")
  String betId;
  @JsonKey(name: "thirdparty_parent_id")
  int thirdpartyParentId;
  @JsonKey(name: "thirdparty_id")
  int thirdpartyId;
  @JsonKey(name: "thirdparty_code")
  String thirdpartyCode;
  @JsonKey(name: "bet_time")
  String betTime;
  @JsonKey(name: "real_bet_amount")
  String realBetAmount;
  @JsonKey(name: "win_loss")
  String winLoss;
  @JsonKey(name: "real_turnover")
  String realTurnover;
  @JsonKey(name: "rebate_turnover")
  String rebateTurnover;
  @JsonKey(name: "bet_content")
  String betContent;

  factory BetTransaction.fromJson(Map<String, dynamic> json) => _$BetTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$BetTransactionToJson(this);
}

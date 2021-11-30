import 'package:tgp_flutter/entity/bank_type.dart';

import 'package:json_annotation/json_annotation.dart';

part 'bet_transaction.g.dart';

@JsonSerializable()
class BetTransaction {
  BetTransaction(
      this.id, this.createdOn, this.gameProviderName, this.betAmount, this.validBetAmount, this.winLoss, this.gameName);

  String id;
  String createdOn;
  String gameProviderName;
  double betAmount;
  double validBetAmount;
  double winLoss;
  String gameName;

  factory BetTransaction.fromJson(Map<String, dynamic> json) => _$BetTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$BetTransactionToJson(this);
}

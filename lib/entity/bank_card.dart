import 'package:tgp_flutter/entity/bank_detail.dart';
import 'package:tgp_flutter/entity/bank_type.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bank_card.g.dart';

@JsonSerializable()

class BankCard {
  BankCard();

  String id;
  @JsonKey(name: "paymentchannelid")
  String paymentChannelId;
  @JsonKey(name: "banktype")
  BankType bankType;
  @JsonKey(name: "detail")
  BankDetail bankDetail;

  factory BankCard.fromJson(Map<String, dynamic> json) => _$BankCardFromJson(json);
  Map<String, dynamic> toJson() => _$BankCardToJson(this);

}
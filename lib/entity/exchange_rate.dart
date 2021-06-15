import 'package:tgp_flutter/entity/bank_detail.dart';
import 'package:tgp_flutter/entity/bank_type.dart';
import 'package:json_annotation/json_annotation.dart';
part 'exchange_rate.g.dart';

@JsonSerializable()

class ExchangeRate {
  ExchangeRate(this.buyPrice, this.sellPrice, this.updateTime);

  @JsonKey(name: "buyprice")
  String buyPrice;
  @JsonKey(name: "sellprice")
  String sellPrice;
  @JsonKey(name: "updatetime")
  String updateTime;

  factory ExchangeRate.fromJson(Map<String, dynamic> json) => _$ExchangeRateFromJson(json);
  Map<String, dynamic> toJson() => _$ExchangeRateToJson(this);

}
import 'package:tgp_flutter/entity/bank_detail.dart';
import 'package:tgp_flutter/entity/bank_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'umpay_exchange_rate.g.dart';

@JsonSerializable()

class UmPayExchangeRate {
  UmPayExchangeRate();

  double rate;
  double fee;
  @JsonKey(name: "in_rate")
  double inRate;
  @JsonKey(name: "out_rate")
  double outRate;

  factory UmPayExchangeRate.fromJson(Map<String, dynamic> json) => _$UmPayExchangeRateFromJson(json);
  Map<String, dynamic> toJson() => _$UmPayExchangeRateToJson(this);

}

import 'package:json_annotation/json_annotation.dart';
part 'bonus_limit.g.dart';
@JsonSerializable()

class BonusLimit {
  BonusLimit();

  @JsonKey(name: 'total_amount')
  String totalAmount;
  String limit;

  
  factory BonusLimit.fromJson(Map<String, dynamic> json) => _$BonusLimitFromJson(json);
  Map<String, dynamic> toJson() => _$BonusLimitToJson(this);
}
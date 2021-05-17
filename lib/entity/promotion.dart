
import 'package:json_annotation/json_annotation.dart';
part 'promotion.g.dart';

@JsonSerializable()

class Promotion {
  Promotion();

  String id;
  String name;
  String from;
  String to;
  int status;
  String promotionType;
  double bonusAmountLimit;
  double amountUsed;
  bool unlimited;
  String gameType;
  double percentage;
  double totalAmountLimit;
  double turnoverMultiple;
  List<String> gameProviderIds;
  List<int> vipLevels;
  String createdOn;
  String updatedOn;
  String createdByUsername;
  String updatedByUsername;

  factory Promotion.fromJson(Map<String, dynamic> json) => _$PromotionFromJson(json);
  Map<String, dynamic> toJson() => _$PromotionToJson(this);
}

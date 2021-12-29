import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/entity/localization.dart';

part 'promotion.g.dart';

@JsonSerializable()
class Promotion {
  Promotion(this.id, this.name, this.from, this.to, this.vipLevels, this.localization, this.mobileBanner, this.content,
      this.terms);

  String? id;
  String? name;
  String? from;
  String? to;
  List<int>? vipLevels;
  Localization? localization;
  String? mobileBanner;
  String? content;
  String? terms;

  factory Promotion.fromJson(Map<String, dynamic> json) => _$PromotionFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionToJson(this);
}

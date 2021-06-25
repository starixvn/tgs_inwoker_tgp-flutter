
import 'package:json_annotation/json_annotation.dart';
part 'promotion_localization.g.dart';

@JsonSerializable()

class PromotionLocalization {
  PromotionLocalization();

  String name;
  String subSubject;
  String content;
  String mobileBanner;

  factory PromotionLocalization.fromJson(Map<String, dynamic> json) => _$PromotionLocalizationFromJson(json);
  Map<String, dynamic> toJson() => _$PromotionLocalizationToJson(this);
}

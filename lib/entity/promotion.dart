
import 'package:json_annotation/json_annotation.dart';
part 'promotion.g.dart';

@JsonSerializable()

class Promotion {
  Promotion();

  @JsonKey(name: 'is_hot')
  int isHot;
  @JsonKey(name: 'type_id')
  int typeId;
  @JsonKey(name: 'm_image_url')
  String imageUrl;

  factory Promotion.fromJson(Map<String, dynamic> json) => _$PromotionFromJson(json);
  Map<String, dynamic> toJson() => _$PromotionToJson(this);
}

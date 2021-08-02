import 'package:json_annotation/json_annotation.dart';
part 'bonus_category.g.dart';

@JsonSerializable()

class BonusCategory {
  BonusCategory();

  @JsonKey(name:"bore_id")
  int boreId;
  @JsonKey(name:"bonus_id")
  int bonusId;
  @JsonKey(name:"type_id")
  BonusCategory typeId;
  int routine;
  String buffer;

  factory BonusCategory.fromJson(Map<String, dynamic> json) => _$BonusCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$BonusCategoryToJson(this);
}

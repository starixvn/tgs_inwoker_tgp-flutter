import 'package:json_annotation/json_annotation.dart';
part 'game_tag.g.dart';

@JsonSerializable()

class GameTag {
  GameTag();

  @JsonKey(name:"new")
  bool isNew;
  @JsonKey(name:"hot")
  bool isHot;
  @JsonKey(name:"recommend")
  bool isRecommend;



  factory GameTag.fromJson(Map<String, dynamic> json) => _$GameTagFromJson(json);
  Map<String, dynamic> toJson() => _$GameTagToJson(this);
}

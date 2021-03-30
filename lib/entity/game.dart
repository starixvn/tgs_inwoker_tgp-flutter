import 'package:json_annotation/json_annotation.dart';
part 'game.g.dart';

@JsonSerializable()

class Game {
  Game();

  int id;
  String code;
  String name;
  String description;
  @JsonKey(name:"gpcode")
  String gamePlatformCode;
  @JsonKey(name:"isactive")
  bool isActive;
  int type;



  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);
}

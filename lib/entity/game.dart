import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/entity/game_tag.dart';
import 'package:tgp_flutter/entity/game_type.dart';
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
  GameType type;
  GameTag tag;

 String gamePlatformName(){
   switch (gamePlatformCode){
     case "HABA":
       return "Habanero";
       break;
     case "SBO":
       return "SBOBET";
       break;
     case "PP":
       return "PragmaticPlay";
       break;
     case "KY":
       return "KY";
       break;
     default:
       return "Habanero";
       break;
   }
 }


  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);
}

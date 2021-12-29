import 'package:flutter/cupertino.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/entity/game_tag.dart';
import 'package:tgp_flutter/entity/game_type.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';

part 'game.g.dart';

@JsonSerializable()
class Game {
  Game(this.id, this.code, this.name, this.description, this.gamePlatformCode, this.isActive, this.type, this.tag,
      this.isFavourite);

  int? id;
  String? code;
  String? name;
  String? description;
  @JsonKey(name: "gpcode")
  String? gamePlatformCode;
  @JsonKey(name: "isactive")
  bool? isActive;
  GameType? type;
  GameTag? tag;

  //String? localizedName; // = getTranslated(context, code);
  bool? isFavourite = false;

  String gamePlatformName() {
    switch (gamePlatformCode) {
      case "HABA":
        return "Habanero";
      case "SBO":
        return "SBOBET";
      case "PP":
        return "PragmaticPlay";
      default:
        return gamePlatformCode!;
    }
  }

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}

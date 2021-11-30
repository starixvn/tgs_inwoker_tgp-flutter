
import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/entity/game_type.dart';
part 'game_provider2.g.dart';

@JsonSerializable()

class GameProvider2 {
  GameProvider2(this.gameType, this.code, this.name, this.description, this.status);

  GameType gameType;
  String code;
  String name;
  String? description;
  int status;

  factory GameProvider2.fromJson(Map<String, dynamic> json) => _$GameProvider2FromJson(json);
  Map<String, dynamic> toJson() => _$GameProvider2ToJson(this);
}

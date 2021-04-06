import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/entity/game_type.dart';
part 'game_provider.g.dart';

@JsonSerializable()

class GameProvider {
  GameProvider();


  String code;
  String name;
  String description;
  int status;
  @JsonKey(name:"gametypes")
  List<GameType> gameTypes;

  factory GameProvider.fromJson(Map<String, dynamic> json) => _$GameProviderFromJson(json);
  Map<String, dynamic> toJson() => _$GameProviderToJson(this);
}

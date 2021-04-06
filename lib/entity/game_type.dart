import 'package:json_annotation/json_annotation.dart';

enum GameType{
  @JsonValue(1) Sportsbook,

  @JsonValue(2) VirtualSports,
  @JsonValue(3) VirtualSportsLobby,

  @JsonValue(4) ESports,
  @JsonValue(5) LiveDealer,
  @JsonValue(6) LiveDealerLobby,
  @JsonValue(7) CardGame,

  @JsonValue(8) CardGameLobby,
  @JsonValue(9) Fishing,
  @JsonValue(10) FishingLobby,
  @JsonValue(11) Arcade,
  @JsonValue(12) ArcadeLobby,

  @JsonValue(13) Lottery,
  @JsonValue(14) LotteryLobby,
  @JsonValue(15) Slot,
  @JsonValue(16) TableGame,
}

extension GameTypeExtension on GameType {

  static const name = {
    GameType.Sportsbook:"Sportsbook",
    GameType.VirtualSports:"VirtualSports",
    GameType.VirtualSportsLobby:"VirtualSportsLobby",
    GameType.ESports:"ESports",
    GameType.LiveDealer:"LiveDealer",
    GameType.LiveDealerLobby:"LiveDealerLobby",
    GameType.CardGame:"CardGame",
    GameType.CardGameLobby:"CardGameLobby",
    GameType.Fishing:"Fishing",
    GameType.FishingLobby:" FishingLobby",
    GameType.Arcade:" Arcade",
    GameType.ArcadeLobby:" ArcadeLobby",
    GameType.Lottery:" Lottery",
    GameType.LotteryLobby:" LotteryLobby",
    GameType.Slot:" Slot",
    GameType.TableGame:" TableGame",

  };

  String get getName => name[this];

}
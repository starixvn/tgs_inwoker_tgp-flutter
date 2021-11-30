import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';

enum GameType {
  @JsonValue(1)
  Sportsbook,

  @JsonValue(2)
  VirtualSports,
  @JsonValue(3)
  VirtualSportsLobby,

  @JsonValue(4)
  ESports,
  @JsonValue(5)
  LiveDealer,
  @JsonValue(6)
  LiveDealerLobby,
  @JsonValue(7)
  CardGame,

  @JsonValue(8)
  CardGameLobby,
  @JsonValue(9)
  Fishing,
  @JsonValue(10)
  FishingLobby,
  @JsonValue(11)
  Arcade,
  @JsonValue(12)
  ArcadeLobby,

  @JsonValue(13)
  Lottery,
  @JsonValue(14)
  LotteryLobby,
  @JsonValue(15)
  Slot,
  @JsonValue(16)
  EGame,
}

extension GameTypeExtension on GameType {
  String getName(BuildContext context) {
    switch(this){
      case GameType.Sportsbook:
        return getTranslatedText(context, "cat_sport");
      case GameType.ESports: 
        return getTranslatedText(context,  "cat_e_sports");
      case GameType.LiveDealerLobby:
        return getTranslatedText(context,  "cat_livecasino");
      case GameType.CardGameLobby:
        return getTranslatedText(context,  "cat_qipai");
      case GameType.Fishing:
        return getTranslatedText(context,  "cat_fish");
      case GameType.LotteryLobby:
        return getTranslatedText(context,  "cat_lottery");
      case GameType.Slot: 
        return getTranslatedText(context,  "cat_slotgame");
      case GameType.EGame:
        return getTranslatedText(context,  "cat_e_game");
      default :
        return "";
    }
  }

  static const json = {
    GameType.Sportsbook: 1,
    GameType.ESports: 4,
    GameType.LiveDealer: 5,
    GameType.LiveDealerLobby: 6,
    GameType.CardGame: 7,
    GameType.CardGameLobby: 8,
    GameType.Fishing: 9,
    GameType.Lottery:13,
    GameType.LotteryLobby: 14,
    GameType.Slot: 15,
    GameType.EGame: 16,
  };

  String getImagePath() {
    switch(this){
      case GameType.Slot:
        return   "slotGame" ;
      case GameType.EGame:
        return   "eGame" ;
      case GameType.Sportsbook:
        return   "sports" ;
      case GameType.LiveDealerLobby:
        return   "live" ;
      case GameType.LotteryLobby:
        return   "lottery" ;
      case GameType.Fishing:
        return   "fish" ;
      case GameType.CardGameLobby:
        return   "qipai" ;
      case GameType.ESports:
        return   "esports" ;
      default :
        return "";
    }
  }

  int? get getJsonValue => json[this];

  getTranslatedText(BuildContext context, String key) => LanguageProvider().getTranslated(context, key);

}

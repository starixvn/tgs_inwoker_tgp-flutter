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
  TableGame,
}

extension GameTypeExtension on GameType {
  static const name = {
    GameType.Sportsbook: "cat_sport",
    GameType.ESports: "cat_laohu",
    GameType.LiveDealer: "cat_livecasino",
    GameType.CardGame: "cat_qipai",
    GameType.Fishing: "cat_fish",
    GameType.Lottery: " cat_lottery",
    GameType.Slot: " cat_slotgame",
    GameType.TableGame: " cat_table",
  };

  static const json = {
    GameType.Sportsbook: 1,
    GameType.ESports: 4,
    GameType.LiveDealer: 5,
    GameType.CardGame: 7,
    GameType.Fishing: 9,
    GameType.Lottery: 13,
    GameType.Slot: 15,
    GameType.TableGame: 16,
  };

  String getDisplayName(BuildContext context) => getTranslatedText(context, name[this]);

  int get getJsonValue => json[this];

  getTranslatedText(BuildContext context, String key) => LanguageProvider().getTranslated(context, key);
}

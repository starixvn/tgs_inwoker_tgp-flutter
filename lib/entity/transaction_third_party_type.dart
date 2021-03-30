import 'package:json_annotation/json_annotation.dart';

enum TransactionThirdPartyType{
  @JsonValue(0) ALL,
  @JsonValue(1) SPORT,
  @JsonValue(2) LOTTERY,
  @JsonValue(3) LIVEGAME,
  @JsonValue(4) QIPAI,
  @JsonValue(5) SLOTGAME,
}

extension TransactionThirdPartyTypeExtension on TransactionThirdPartyType {

  static const name = {
    TransactionThirdPartyType.ALL:  "全部",
    TransactionThirdPartyType.SPORT:  "体育",
    TransactionThirdPartyType.LOTTERY:  "彩票",
    TransactionThirdPartyType.LIVEGAME:  "真人",
    TransactionThirdPartyType.QIPAI:  "棋牌",
    TransactionThirdPartyType.SLOTGAME:  "小游戏",
  };

  static const jsonValue = {
    TransactionThirdPartyType.ALL:  "0",
    TransactionThirdPartyType.SPORT:  "1",
    TransactionThirdPartyType.LOTTERY:  "2",
    TransactionThirdPartyType.LIVEGAME:  "3",
    TransactionThirdPartyType.QIPAI:  "4",
    TransactionThirdPartyType.SLOTGAME:  "5",
  };

  String get displayName => name[this];
  String get getJsonValue => jsonValue[this];

}
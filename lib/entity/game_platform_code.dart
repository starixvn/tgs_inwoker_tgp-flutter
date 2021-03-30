import 'package:json_annotation/json_annotation.dart';

enum GamePlatformCode{
  @JsonValue(10000) MAIN_WALLET,

  @JsonValue(60000) ESPORT_MRCAT,
  @JsonValue(30000) ESPORT_SABAH,

  @JsonValue(180000) LIVE_AG,
  @JsonValue(20009) LIVE_BBIN,
  @JsonValue(120000) LIVE_DG,
  @JsonValue(41012) LIVE_MG,
  LIVE_BG,

  LOTTERY_633,
  LOTTERY_IG,

  @JsonValue(150000) QIPAI_KY,
  @JsonValue(250000) QIPAI_AP,
  @JsonValue(130000) QIPAI_AS,
  @JsonValue(170000) QIPAI_BOLE,
  @JsonValue(190000) QIPAI_LEYOU,

  @JsonValue(40000) SLOT_MG,
  @JsonValue(110000) SLOT_JDB,
  @JsonValue(180000) SLOT_AG,
  @JsonValue(140000) SLOT_BBIN,
  @JsonValue(100000) SLOT_PNG,
  @JsonValue(90000) SLOT_QT,
  SLOT_ALL,
}

extension GamePlatformCodeExtension on GamePlatformCode {

  static const name = {
    GamePlatformCode.MAIN_WALLET:  "主账号",
    
    GamePlatformCode.ESPORT_MRCAT: "633彩票与体育",
    GamePlatformCode.ESPORT_SABAH: "沙巴体育",
    
    GamePlatformCode.LIVE_AG: "AG真人",
    GamePlatformCode.LIVE_BBIN: "BBIN真人",
    GamePlatformCode.LIVE_DG: "DG真人",
    GamePlatformCode.LIVE_MG: "MG真人",
    GamePlatformCode.LIVE_BG: "BG真人",

    GamePlatformCode.LOTTERY_633: "633彩票",
    GamePlatformCode.LOTTERY_IG: "IG彩票",

    GamePlatformCode.QIPAI_KY: "KY棋牌",
    GamePlatformCode.QIPAI_AP: "爱棋牌",
    GamePlatformCode.QIPAI_AS: "AS棋牌",
    GamePlatformCode.QIPAI_BOLE: "博乐棋牌",
    GamePlatformCode.QIPAI_LEYOU: "乐游棋牌",

    GamePlatformCode.SLOT_MG: "MG",
    GamePlatformCode. SLOT_JDB: "JDB",
    GamePlatformCode. SLOT_AG: "AG",
    GamePlatformCode. SLOT_BBIN: "BBIN",
    GamePlatformCode. SLOT_PNG: "PNG",
    GamePlatformCode.SLOT_QT: "QT",
    GamePlatformCode.SLOT_ALL: "ALL",
  };

  static const jsonValue = {
    GamePlatformCode.MAIN_WALLET:  "10000",
    
    GamePlatformCode.ESPORT_MRCAT: "60000",
    GamePlatformCode.ESPORT_SABAH: "30000",
    
    GamePlatformCode.LIVE_AG: "180000",
    GamePlatformCode.LIVE_BBIN: "20009",
    GamePlatformCode.LIVE_DG: "120000",
    GamePlatformCode.LIVE_MG: "41012",
    GamePlatformCode.LIVE_BG: "100",

    GamePlatformCode.QIPAI_KY: "150000",
    GamePlatformCode.QIPAI_AP: "250000",
    GamePlatformCode.QIPAI_AS: "130000",
    GamePlatformCode.QIPAI_BOLE: "170000",
    GamePlatformCode.QIPAI_LEYOU: "150000",

    GamePlatformCode.SLOT_MG: "40000",
    GamePlatformCode. SLOT_JDB: "110000",
    GamePlatformCode. SLOT_AG: "180000",
    GamePlatformCode. SLOT_BBIN: "140000",
    GamePlatformCode. SLOT_PNG: "100000",
    GamePlatformCode.SLOT_QT: "90000",
  };

  static const gameCode = {
    GamePlatformCode.LOTTERY_633: "lobby",
    GamePlatformCode.LOTTERY_IG: "GFC",
  };

  String get displayName => name[this];
  String get getJsonValue => jsonValue[this];
  String get getGameCode => gameCode[this??""];


}
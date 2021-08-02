import 'package:json_annotation/json_annotation.dart';

class VipLevelInfo {
  VipLevelInfo(
  int birthdayBonus,
  double casinoBonusPa,
  double dpBonusPa,
  int dpMaxLimit,
  int levelID,
  int levelUpBonus,
  double lottoryBonusPa,
  double slotBonusPa,
  double sportBonusPa,
  int turnoverAmountMonthly,
  int turnoverAmountInYear,
  int vipHelpBonusLimit){
    this.birthdayBonus = birthdayBonus;
    this.casinoBonusPa = casinoBonusPa;
    this.dpBonusPa = dpBonusPa;
    this.dpMaxLimit = dpMaxLimit;
    this.levelID = levelID;
    this.levelUpBonus = levelUpBonus;
    this.lottoryBonusPa = lottoryBonusPa;
    this.slotBonusPa = slotBonusPa;
    this.sportBonusPa = sportBonusPa;
    this.turnoverAmountMonthly = turnoverAmountMonthly;
    this.turnoverAmountInYear = turnoverAmountInYear;
    this.vipHelpBonusLimit = vipHelpBonusLimit;
  }

  int birthdayBonus;
  @JsonKey(name: 'parent_id')
  double casinoBonusPa;
  double dpBonusPa;
  int dpMaxLimit;
  int levelID;
  int levelUpBonus;
  double lottoryBonusPa;
  double slotBonusPa;
  double sportBonusPa;
  int turnoverAmountMonthly;
  int turnoverAmountInYear;
  int vipHelpBonusLimit;

  String getVipIconPath(){
    switch(levelID){
      case 2: {
        return "images/vip/ic_vip1.png";
        break;
      }
      case 3: {
        return "images/vip/ic_vip2.png";
      }
      case 4: {
        return "images/vip/ic_vip3.png";
      }
      case 5: {
        return "images/vip/ic_vip4.png";
      }
      case 6: {
        return "images/vip/ic_vip5.png";
      }
      default:{
        return "images/vip/ic_vip0.png";
      }
    }
  }

  int getVipLevelText(){
    return levelID -1;
  }

  String getWithdrawalLimit(){
    var count;
    switch(levelID){
      case 2: {
        count = 8;
        break;
      }
      case 3: {
        count = 9;
        break;
      }
      case 4: {
        count = 10;
        break;
      }
      case 5: {
        count = 12;
        break;
      }
      case 6: {
        count = -1;
        break;
      }
      default:{
        count = 7;
        break;
      }
    }

    if(count ==-1){
      return "无限次";
    }else{
      return "$count次";
    }
  }
}
import 'package:json_annotation/json_annotation.dart';
import 'bonus_category.dart';
part 'bonus.g.dart';

@JsonSerializable()

class Bonus {
  Bonus();

  @JsonKey(name:"bore_id")
  int boreId;
  @JsonKey(name:"bonus_id")
  int bonusId;
  @JsonKey(name:"type_id")
  BonusCategory typeId;
  int routine;
  String amount;
  @JsonKey(name:"turnover_num")
  String turnoverNum;
  @JsonKey(name:"image_id")
  int imageId;
  @JsonKey(name:"create_time")
  String createTime;
  @JsonKey(name:"start_time")
  String startTime;
  @JsonKey(name:"end_time")
  String endTime;
  @JsonKey(name:"expired_time")
  String expiredTime;
  @JsonKey(name:"turnover_platform_id")
  int turnoverPlatformId;
  @JsonKey(name:"turnover_platform_type_id")
  int turnoverPlatformTypeId;
  @JsonKey(name:"turnover_thirdparty_id")
  int turnoverThirdpartyId;
  @JsonKey(name:"turnover_thirdparty_parent_id")
  int turnoverThirdpartyParentId;
  @JsonKey(name:"pass_account")
  int passAccount;
  @JsonKey(name:"pass_email")
  int passEmail;
  @JsonKey(name:"pass_phone")
  int passPhone;
  String deposited;
  String title;
  String remark;
  @JsonKey(name:"calc_start_time")
  int calcStartTime;
  @JsonKey(name:"calc_end_time")
  int calcEndTime;
  @JsonKey(name:"deposit_from")
  int depositFrom;
  @JsonKey(name:"deposit_to")
  int depositTo;
  @JsonKey(name:"turnover_from")
  int turnoverFrom;
  @JsonKey(name:"turnover_to")
  int turnoverTo;
  @JsonKey(name:"current_deposit")
  String currentDeposit;
  @JsonKey(name:"current_turnover")
  String currentTurnover;
  @JsonKey(name:"check_turnover")
  bool checkTurnover;
  @JsonKey(name:"rate_turnover")
  int rateTurnover;
  @JsonKey(name:"check_deposited")
  bool checkDeposit;
  @JsonKey(name:"rate_deposit")
  int rateDeposit;
  @JsonKey(name:"check_pass_account")
  bool checkPassAccount;
  @JsonKey(name:"check_pass_email")
  bool checkPassEmail;
  @JsonKey(name:"check_pass_phone")
  bool checkPassPhone;
  @JsonKey(name:"show_btn")
  int showBtn;
  @JsonKey(name:"child_exist")
  int childExist = -1; // default 0
  @JsonKey(name:"image_url")
  String imageUrl;
  @JsonKey(name:"turnover_limit")
  String turnoverLimit;
  String day = "";

  factory Bonus.fromJson(Map<String, dynamic> json) => _$BonusFromJson(json);
  Map<String, dynamic> toJson() => _$BonusToJson(this);
}

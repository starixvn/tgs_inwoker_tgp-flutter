import 'package:tgp_flutter/entity/vip_level_info.dart';
import 'package:tgp_flutter/entity/vip_progress.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vip_detail.g.dart';
@JsonSerializable()

class VipDetail {
  VipDetail();

  String member;
  @JsonKey(name: 'next_vip_title')
  String nextVipTitle;
  @JsonKey(name: 'owned_point')
  String ownedPoint;
  @JsonKey(name: 'next_point')
  String nextPoint;
  @JsonKey(name: 'require_point')
  String requirePoint;
  @JsonKey(name: 'vip_progress_bar')
  int vipProgressBar;
 @JsonKey(name: 'curr_vip')
  VipProgress currVip;
  @JsonKey(name: 'next_vip')
  VipProgress nextVip;

  factory VipDetail.fromJson(Map<String, dynamic> json) => _$VipDetailFromJson(json);
  Map<String, dynamic> toJson() => _$VipDetailToJson(this);

  List<VipLevelInfo> getLevelList(){
    List<VipLevelInfo> levelList = [];
    levelList.add(
        VipLevelInfo(0,
        100.58,
        0.0,
        0,
        1,
        0,
        100.5,
        100.76,
        100.18,
        0,
        0,
        0));
    levelList.add(
        VipLevelInfo(
        588,
        100.7,
        0.0,
        0,
        2,
        888,
        100.7,
        100.9,
        100.28,
        3000,
        30000,
        500
    ));

    levelList.add(
        VipLevelInfo(
        888,
        100.8,
        10.0,
        2000,
        3,
        1888,
        100.9,
        101.0,
        100.38,
        8000,
        80000,
        1500
    ));

    levelList.add(
        VipLevelInfo(
        1888,
        100.9,
        20.0,
        5000,
        4,
        3888,
        101.0,
        101.1,
        100.48,
        25000,
        250000,
        8000
    ));

    levelList.add(
        VipLevelInfo(
        8888,
        101.0,
        30.0,
        10000,
        5,
        18888,
        101.1,
        101.2,
        100.58,
        75000,
        750000,
        35000
    ));

    levelList.add(
        VipLevelInfo(
        88888,
        101.2,
        40.0,
        18000,
        6,
        108888,
        101.2,
        101.5,
        100.78,
        350000,
        2500000,
        350000
    ));
    return levelList;
  }
}
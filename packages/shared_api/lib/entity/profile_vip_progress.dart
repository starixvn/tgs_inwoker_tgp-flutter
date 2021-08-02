import 'package:json_annotation/json_annotation.dart';
part 'profile_vip_progress.g.dart';
@JsonSerializable()

class ProfileVIPProgress {
  ProfileVIPProgress();

  int id;
  @JsonKey(name: 'curr_title')
  String currTitle;
  @JsonKey(name: 'curr_owned_point')
  String currPoint;
  @JsonKey(name: 'next_title')
  String nextTitle;
  @JsonKey(name: 'next_point')
  String nextPoint;
  @JsonKey(name: 'require_point')
  String requirePoint;
  @JsonKey(name: 'vip_progress_bar')
  int vipProgressBar;


  factory ProfileVIPProgress.fromJson(Map<String, dynamic> json) => _$ProfileVIPProgressFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileVIPProgressToJson(this);
}
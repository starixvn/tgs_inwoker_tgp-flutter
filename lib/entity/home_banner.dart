import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/entity/localization.dart';
part 'home_banner.g.dart';
@JsonSerializable()

class HomeBanner {
  HomeBanner();

  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'mobileurl')
  String mobileUrl;
  String title;

  factory HomeBanner.fromJson(Map<String, dynamic> json) => _$HomeBannerFromJson(json);
  Map<String, dynamic> toJson() => _$HomeBannerToJson(this);
}

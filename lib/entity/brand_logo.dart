import 'package:json_annotation/json_annotation.dart';
part 'brand_logo.g.dart';
@JsonSerializable()

class BrandLogo {
  BrandLogo();

  @JsonKey(name: 'brandId')
  String id;
  @JsonKey(name: 'mobileLogoUrl')
  String mobileUrl;

  factory BrandLogo.fromJson(Map<String, dynamic> json) => _$BrandLogoFromJson(json);
  Map<String, dynamic> toJson() => _$BrandLogoToJson(this);
}

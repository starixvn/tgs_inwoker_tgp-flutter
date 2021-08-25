import 'package:json_annotation/json_annotation.dart';
part 'language_option.g.dart';

@JsonSerializable()

class LanguageOption {
  LanguageOption();

  @JsonKey(name: "culturecode")
  String code;

  factory LanguageOption.fromJson(Map<String, dynamic> json) => _$LanguageOptionFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageOptionToJson(this);

}

import 'package:json_annotation/json_annotation.dart';
part 'localization.g.dart';

@JsonSerializable()

class Localization {
  Localization();

  String name;
  String subSubject;
  String content;
  String mobileBanner;

  factory Localization.fromJson(Map<String, dynamic> json) => _$LocalizationFromJson(json);
  Map<String, dynamic> toJson() => _$LocalizationToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
part 'security_question.g.dart';
@JsonSerializable()

class SecurityQuestion {
  SecurityQuestion();

  @JsonKey(name: 'id')
  int securityQuestionId;
  @JsonKey(name: 'title')
  String securityQuestionName;

  
  factory SecurityQuestion.fromJson(Map<String, dynamic> json) => _$SecurityQuestionFromJson(json);
  Map<String, dynamic> toJson() => _$SecurityQuestionToJson(this);
}
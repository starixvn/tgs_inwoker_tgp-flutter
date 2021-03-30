
import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable()

class LoginResponse {
  LoginResponse(this.code, this.msg, this.token, this.expires);

  @JsonKey(name: 'err')
  int code;
  @JsonKey(name: 'errmsg')
  String msg;
  String token;
  int expires;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

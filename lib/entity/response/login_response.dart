
import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable()

class LoginResponse {
  LoginResponse(this.token, this.expires);

  String token;
  int expires;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

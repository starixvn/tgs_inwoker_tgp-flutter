import 'package:json_annotation/json_annotation.dart';
part 'user_profile.g.dart';
@JsonSerializable()

class UserProfile {
  UserProfile();

  String username;
  String realname;
  String phone;
  String email;
  String qq;
  String wechat;
  @JsonKey(name: 'issetpaypassword')
  bool isSetPayPassword;
  @JsonKey(name: 'identityauthentication')
  bool identityAuthentication;


  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
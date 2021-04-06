import 'package:tgp_flutter/entity/response/check_username_response.dart';
import 'package:tgp_flutter/entity/response/login_response.dart';
import 'package:tgp_flutter/entity/response/register_response.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/network/services/api_service.dart';

import 'base_repository.dart';

class UserRepository extends BaseRepository{
  static UserRepository _singleton;
  UserProfile userProfile;

  static UserRepository getSingleton(){
    if(_singleton == null){
      _singleton = UserRepository();
    }
    return _singleton;
  }

  Future<EventResult<LoginResponse>> login(
      String username,
      String password
      ) async{
    var response = await apiPost(
        "api/Player/login",
        {
          "username": username,
          "password": password,
          "platformtype": 1,
        });
    return resolveResponse(response,(json) => LoginResponse.fromJson(json));
  }

  Future<EventResult<RegisterResponse>> register(
      String username,
      String password,
      String rpassword,
      String currency,
      String invitationCode
      ) async{
    var response = await apiPost(
        "api/Player/create",
        {
          "username": username,
          "currency": currency,
          "pwd": password,
          "confirmpwd": rpassword,
          "invitationcode": invitationCode,
          "agent": true,
          "testplayer": true
        });
    return resolveResponse(response,(json) => RegisterResponse.fromJson(json));
  }

  Future<EventResult<UserProfile>> getBasicInfo() async {
    var response = await apiGet("api/Player/info");
    return resolveBaseResponse(response,(json) => UserProfile.fromJson(json),(result) => userProfile = result);
  }

  Future<EventResult<String>> logout() async{
    var response = await apiDelete(
        "api/Player/logout",
        {
        });
    userProfile = null;
    return resolveBaseResponse(response,(json) => (json as String));
  }

  Future<EventResult<LoginResponse>> auth() async{
    var response = await apiPost(
        "api/Auth/jwt",
        {
          "client": "I7nKiimrZQOqnJ6ryjUw74c0Hi64KC6Myunhob4cHh8VOUIuZh4p63czefxyyzbZ",
          "currency": "CNY"
        });
    return resolveResponse(response,(json) => LoginResponse.fromJson(json));
  }

  Future<EventResult<CheckUsernameResponse>> checkUsername(String username) async{
    var response = await apiGet(
        "api/player/checkUsername",
        {
          "username": username,
        });
    return resolveResponse(response,(json) => CheckUsernameResponse.fromJson(json));
  }

  Future<EventResult<dynamic>> setQQAccount(String qq) async{
    var response = await apiPatch(
        "api/player/qq",
        {
          "qq": qq
        });
    return resolveResponse(response,(json) => json as dynamic);
  }
  Future<EventResult<dynamic>> setWechatAccount(String wechat) async{
    var response = await apiPatch(
        "api/player/wechat",
        {
          "wechat": wechat
        });
    return resolveResponse(response,(json) => json as dynamic);
  }

  Future<EventResult<dynamic>> editPassword(String oldPassword, String newPassword) async{
    var response = await apiPut(
        "api/player/password",
        {
          "oldpwd": oldPassword,
          "newpwd": newPassword,
        });
    return resolveResponse(response,(json) => json as dynamic);
  }

  Future<EventResult<dynamic>> setIdentity (String realname, String id) async{
    var response = await apiPatch(
        "api/player/identity",
        {
          "id": id,
          "realname": realname,
        });
    return resolveResponse(response,(json) => json as dynamic);
  }

  Future<EventResult<dynamic>> checkIdVerification (String id) async{
    var response = await apiGet(
        "api/player/identity/check",
        {
          "id": id,
        });
    return resolveResponse(response,(json) => json as dynamic);
  }
}
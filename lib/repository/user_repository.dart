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
          "platformtype": 0,
        },false);
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
        },false);
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
        "api/Player/checkUsername",
        content:{
          "username": username,
        });
    return resolveResponse(response,(json) => CheckUsernameResponse.fromJson(json));
  }
}
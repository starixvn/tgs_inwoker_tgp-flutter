
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/response/game_url_response.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/network/services/api_service.dart';

import 'base_repository.dart';

class AuthenticationRepository extends BaseRepository {
  static AuthenticationRepository _singleton;
  UserProfile userProfile;

  static AuthenticationRepository getSingleton() {
    if (_singleton == null) {
      _singleton = AuthenticationRepository();
    }
    return _singleton;
  }

  Future<EventResult<String>> emailVerify(String email) async {
    var response = await apiPost(
        "api/player/email",
        {
          "email": email,
        });
    return resolveBaseResponse(response, (json) => json as String);
  }

  Future<EventResult<String>> verifyCode(String securityKey, String validateCode,{bool isPhone=false}) async {
    var response = await apiPut(
        isPhone?"api/player/phone": "api/player/email",
        {
          "securitykey": securityKey,
          "validatecode": validateCode
        });
    return resolveBaseResponse(response, (json) => json as String);
  }

  Future<EventResult<String>> phoneVerify(String phone) async {
    var response = await apiPost(
        "api/player/phone",
        {
          "phone": phone,
        });
    return resolveBaseResponse(response, (json) => json as String);
  }

  Future<EventResult<String>> getForgotPasswordCode(String phone) async {
    var response = await apiPost(
        "api/player/password/forgot",
        {
          "phone": phone,
        }, false);
    return resolveBaseResponse(response, (json) => json as String);
  }

  Future<EventResult<String>> resetPassword(String securityKey, String validateCode, String newPassword) async {
    var response = await apiPost(
        "api/player/password/reset",
        {
          "securitykey": securityKey,
          "validatecode": validateCode,
          "newpwd": newPassword
        },false);
    return resolveBaseResponse(response, (json) => json as String);
  }

  Future<EventResult<dynamic>> addPayPassword(String password) async{
    var response = await apiPost(
        "api/pay/password",
        {
          "pwd": password
        });
    return resolveBaseResponse(response,(json) => json as dynamic);
  }

  Future<EventResult<dynamic>> getPayPasswordCode() async{
    var response = await apiPost(
        "api/pay/password/validate-code",
        {
        });
    return resolveBaseResponse(response,(json) => json as dynamic);
  }

  Future<EventResult<dynamic>> payPasswordVerify (String password, String  code, String securityKey) async{
    var response = await apiPatch(
        "api/pay/password",
        {
          "newpwd": password,
          "validatecode": code,
          "securitykey": securityKey
        });
    return resolveBaseResponse(response,(json) => json as dynamic);
  }
}
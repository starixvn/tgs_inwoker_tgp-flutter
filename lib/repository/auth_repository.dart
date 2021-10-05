import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/http_method.dart';
import 'package:tgp_flutter/entity/response/game_url_response.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/network/api_request_builder.dart';
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

  Future<EventResult<dynamic>> emailVerify(String email) async {
    return await ApiRequestBuilder<dynamic>(
            endPoint: "api/Player/email",
            params: {
              "email": email,
            },
            jwtRefresher: jwtAuth,
            timeout: 10)
        .execute();
  }

  Future<EventResult<dynamic>> submitVerifyCode(String securityKey, String validateCode, {bool isPhone = false}) async {
    return await ApiRequestBuilder<dynamic>(
            method: HttpMethod.PUT,
            endPoint: isPhone ? "api/player/phone" : "api/player/email",
            params: {"securitykey": securityKey, "validatecode": validateCode},
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> getPhoneVerifyCode(String area, String phone) async {
    return await ApiRequestBuilder<dynamic>(
            endPoint: "api/player/phone",
            params: {
              "area":area,
              "phone": phone,
            },
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> getForgotPasswordCode(String email, String phone, String areaCode) async {
    return await ApiRequestBuilder<dynamic>(
            isAuthorization: false,
            endPoint: "api/player/password/forgot",
            params: {
              "email": email,
              "phone": phone,
              "areaCode": areaCode,
            },
            jwtRefresher: jwtAuth,
            timeout: 10)
        .execute();
  }

  Future<EventResult<dynamic>> resetPassword(String securityKey, String validateCode, String newPassword) async {
    return await ApiRequestBuilder<dynamic>(
            isAuthorization: false,
            endPoint: "api/player/password/reset",
            params: {"securitykey": securityKey, "validatecode": validateCode, "newpwd": newPassword},
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> addPayPassword(String password) async {
    return await ApiRequestBuilder<dynamic>(
            endPoint: "api/pay/password", params: {"pwd": password}, jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> getPayPasswordCode() async {
    return await ApiRequestBuilder<dynamic>(
            endPoint: "api/pay/password/validate-code", params: {}, jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> payPasswordVerify(String password, String code, String securityKey) async {
    return await ApiRequestBuilder<dynamic>(
            method: HttpMethod.PATCH,
            endPoint: "api/pay/password",
            params: {"newpwd": password, "validatecode": code, "securitykey": securityKey},
            jwtRefresher: jwtAuth)
        .execute();
  }


  Future<EventResult<dynamic>> getReVerifyCode(String username, String password, String areaCode, String phone) async {
    return await ApiRequestBuilder<dynamic>(
        endPoint: "api/player/init-phone",
        params: {"username": username, "pwd": password, "areacode": areaCode, "phone": phone},
        jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> phoneReVerify(String securityKey, validateCode) async {
    return await ApiRequestBuilder<dynamic>(
        method: HttpMethod.PUT,
        endPoint: "api/player/init-phone",
        params: {"securitykey": securityKey, "validatecode": validateCode},
        jwtRefresher: jwtAuth)
        .execute();
  }

}

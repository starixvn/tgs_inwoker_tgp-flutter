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

  Future<EventResult<dynamic>> verifyCode(String securityKey, String validateCode, {bool isPhone = false}) async {
    return await ApiRequestBuilder<dynamic>(
            method: HttpMethod.PUT,
            endPoint: isPhone ? "api/player/phone" : "api/player/email",
            params: {"securitykey": securityKey, "validatecode": validateCode},
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> phoneVerify(String phone) async {
    return await ApiRequestBuilder<dynamic>(
            endPoint: "api/player/phone",
            params: {
              "phone": phone,
            },
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> getForgotPasswordCode(String phone) async {
    return await ApiRequestBuilder<dynamic>(
            isAuthorization: false,
            endPoint: "api/player/password/forgot",
            params: {
              "email": phone,
            },
            jwtRefresher: jwtAuth)
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
}

import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
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

  Future<EventResult<String>> emailVerify(String email) async {
    return await ApiRequestBuilder<String>(
            method: HttpMethod.POST,
            endPoint: "api/Player/email",
            params: {
              "email": email,
            },
            converter: (json) => json as String,
            resolver: resolveResponse,
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<String>> verifyCode(String securityKey, String validateCode, {bool isPhone = false}) async {
    return await ApiRequestBuilder<String>(
            method: HttpMethod.PUT,
            endPoint: isPhone ? "api/player/phone" : "api/player/email",
            params: {"securitykey": securityKey, "validatecode": validateCode},
            converter: (json) => json as String,
            resolver: resolveBaseResponse,
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<String>> phoneVerify(String phone) async {
    return await ApiRequestBuilder<String>(
            method: HttpMethod.POST,
            endPoint: "api/player/phone",
            params: {
              "phone": phone,
            },
            converter: (json) => json as String,
            resolver: resolveBaseResponse,
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<String>> getForgotPasswordCode(String phone) async {
    return await ApiRequestBuilder<String>(
            method: HttpMethod.POST,
            isAuthorization: false,
            endPoint: "api/player/password/forgot",
            params: {
              "phone": phone,
            },
            converter: (json) => json as String,
            resolver: resolveBaseResponse,
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<String>> resetPassword(String securityKey, String validateCode, String newPassword) async {
    return await ApiRequestBuilder<String>(
            method: HttpMethod.POST,
            isAuthorization: false,
            endPoint: "api/player/password/reset",
            params: {"securitykey": securityKey, "validatecode": validateCode, "newpwd": newPassword},
            converter: (json) => json as String,
            resolver: resolveBaseResponse,
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<String>> addPayPassword(String password) async {
    return await ApiRequestBuilder<String>(
            method: HttpMethod.POST,
            endPoint: "api/pay/password",
            params: {"pwd": password},
            converter: (json) => json as String,
            resolver: resolveBaseResponse,
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<String>> getPayPasswordCode() async {
    return await ApiRequestBuilder<String>(
            method: HttpMethod.POST,
            endPoint: "api/pay/password/validate-code",
            params: {},
            converter: (json) => json as String,
            resolver: resolveBaseResponse,
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<String>> payPasswordVerify(String password, String code, String securityKey) async {
    return await ApiRequestBuilder<String>(
            method: HttpMethod.PATCH,
            endPoint: "api/pay/password",
            params: {"newpwd": password, "validatecode": code, "securitykey": securityKey},
            converter: (json) => json as String,
            resolver: resolveBaseResponse,
            jwtRefresher: jwtAuth)
        .execute();
  }
}

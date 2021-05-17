import 'package:flutter/cupertino.dart';
import 'package:tgp_flutter/entity/bank_card.dart';
import 'package:tgp_flutter/entity/http_method.dart';
import 'package:tgp_flutter/entity/response/check_username_response.dart';
import 'package:tgp_flutter/entity/response/edit_password_response.dart';
import 'package:tgp_flutter/entity/response/list_response.dart';
import 'package:tgp_flutter/entity/response/login_response.dart';
import 'package:tgp_flutter/entity/response/register_response.dart';
import 'package:tgp_flutter/entity/bet_transaction.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/entity/wallet.dart';
import 'package:tgp_flutter/entity/withdrawal_info.dart';
import 'package:tgp_flutter/network/api_request_builder.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/network/services/api_service.dart';

import 'base_repository.dart';

class UserRepository extends BaseRepository {
  static UserRepository _singleton;
  UserProfile userProfile;
  Wallet wallet;

  static UserRepository getSingleton() {
    if (_singleton == null) {
      _singleton = UserRepository();
    }
    return _singleton;
  }

  Future<EventResult<LoginResponse>> login(String username, String password) async {
    return await ApiRequestBuilder<LoginResponse>(
            isAuthorization: false,
            endPoint: "api/Player/login",
            params: {
              "username": username,
              "password": password,
              "platformtype": 1,
            },
            converter: (json) => LoginResponse.fromJson(json),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<RegisterResponse>> register(
      String username, String password, String rpassword, String currency, String invitationCode) async {
    return await ApiRequestBuilder<RegisterResponse>(
            isAuthorization: false,
            endPoint: "api/Player/create",
            params: {
              "username": username,
              "currency": currency,
              "pwd": password,
              "confirmpwd": rpassword,
              "invitationcode": invitationCode,
              "agent": true,
              "testplayer": true
            },
            converter: (json) => RegisterResponse.fromJson(json),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<UserProfile>> getBasicInfo() async {
    return await ApiRequestBuilder<UserProfile>(
            method: HttpMethod.GET,
            endPoint: "api/Player/info",
            converter: (json) => UserProfile.fromJson(json),
            consumer: (result) => userProfile = result,
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> logout() async {
    var apiState = await ApiRequestBuilder<dynamic>(
            method: HttpMethod.DELETE, endPoint: "api/Player/logout", jwtRefresher: jwtAuth)
        .execute();
    userProfile = null;
    return apiState;
  }

  Future<EventResult<LoginResponse>> auth() async {
    return jwtAuth();
  }

  Future<EventResult<CheckUsernameResponse>> checkUsername(String username) async {
    return await ApiRequestBuilder<CheckUsernameResponse>(
            method: HttpMethod.GET,
            endPoint: "api/player/checkUsername",
            params: {
              "username": username,
            },
            converter: (json) => CheckUsernameResponse.fromJson(json),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> setQQAccount(String qq) async {
    return await ApiRequestBuilder<dynamic>(
            method: HttpMethod.PATCH,
            endPoint: "api/player/qq",
            params: {
              "qq": qq,
            },
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> setWechatAccount(String wechat) async {
    return await ApiRequestBuilder<dynamic>(
            method: HttpMethod.PATCH,
            endPoint: "api/player/wechat",
            params: {
              "wechat": wechat,
            },
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<EditPasswordResponse>> editPassword(String oldPassword, String newPassword) async {
    return await ApiRequestBuilder<EditPasswordResponse>(
            method: HttpMethod.PUT,
            endPoint: "api/player/password",
            params: {
              "oldpwd": oldPassword,
              "newpwd": newPassword,
            },
            converter: (json) => EditPasswordResponse.fromJson(json),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> setIdentity(String realname, String id) async {
    return await ApiRequestBuilder<dynamic>(
            method: HttpMethod.PATCH,
            endPoint: "api/player/identity",
            params: {
              "id": id,
              "realname": realname,
            },
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> checkIdVerification(String id) async {
    return await ApiRequestBuilder<dynamic>(
            method: HttpMethod.GET,
            endPoint: "api/player/identity/check",
            params: {
              "id": id,
            },
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<ListResponse<BetTransaction>>> getTransaction(
    DateTime startDate,
    DateTime endDate,
    int page,
    int rows,
    /*int orderBy,
      bool isDesc,
      String sortBy,
      bool showAll*/
  ) async {
    return await ApiRequestBuilder<ListResponse<BetTransaction>>(
            method: HttpMethod.GET,
            endPoint: "api/playerreport/rounds",
            params: {
              "From": startDate.toString(),
              "To": endDate.toString(),
              "Page": page.toString(),
              "Rows": rows.toString(),
              /*"OrderBy":orderBy.toString(),
          "IsDesc":isDesc.toString(),
          "SortBy":sortBy,
          "ShowAll":showAll.toString(),*/
            },
            converter: (json) => ListResponse.fromJson(json, (res) => BetTransaction.fromJson(res)),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<Wallet>> getWalletBalance() async {
    return await ApiRequestBuilder<Wallet>(
            method: HttpMethod.GET,
            endPoint: "api/Wallet",
            converter: (json) => Wallet.fromJson(json),
            consumer: (result) => wallet = result,
            jwtRefresher: jwtAuth)
        .execute();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/entity/account_report.dart';
import 'package:tgp_flutter/entity/bank_card.dart';
import 'package:tgp_flutter/entity/bet_report.dart';
import 'package:tgp_flutter/entity/brand_communication.dart';
import 'package:tgp_flutter/entity/live_chat.dart';
import 'package:tgp_flutter/entity/promotion_report.dart';
import 'package:tgp_flutter/entity/response/report_response2.dart';
import 'package:tgp_flutter/entity/transfer_report.dart';
import 'package:tgp_flutter/entity/http_method.dart';
import 'package:tgp_flutter/entity/response/check_username_response.dart';
import 'package:tgp_flutter/entity/response/edit_password_response.dart';
import 'package:tgp_flutter/entity/response/list_response.dart';
import 'package:tgp_flutter/entity/response/login_response.dart';
import 'package:tgp_flutter/entity/response/register_response.dart';
import 'package:tgp_flutter/entity/response/report_response.dart';
import 'package:tgp_flutter/entity/status.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/entity/main_wallet.dart';
import 'package:tgp_flutter/entity/withdrawal_info.dart';
import 'package:tgp_flutter/environment_config.dart';
import 'package:tgp_flutter/network/api_request_builder.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/network/services/api_service.dart';

import 'base_repository.dart';

class UserRepository extends BaseRepository {
  static UserRepository? _singleton;
  UserProfile? userProfile;
  MainWallet? wallet;
  Map<String, dynamic>? apiError;

  static UserRepository getSingleton() {
    if (_singleton == null) {
      _singleton = UserRepository();
    }
    return _singleton!;
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
      String username, String password, String rpassword, String invitationCode) async {
    return await ApiRequestBuilder<RegisterResponse>(
            isAuthorization: false,
            endPoint: "api/Player/create",
            params: {
              "username": username,
              "currency": EnvironmentConfig.currency,
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
            consumer: (result) => setRepoValues(() {
                  userProfile = result;
                }),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> logout() async {
    var apiState = await ApiRequestBuilder<dynamic>(
            method: HttpMethod.DELETE, endPoint: "api/Player/logout", jwtRefresher: jwtAuth)
        .execute();
    await clearSession();
    return apiState;
  }

  clearSession() async {
    userProfile = null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
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

  Future<EventResult<ListResponse<BetReport>>> getReport(
    DateTime startDate,
    DateTime endDate,
    int page,
    int rows,
    /*int orderBy,
      bool isDesc,
      String sortBy,
      bool showAll*/
  ) async {
    return await ApiRequestBuilder<ListResponse<BetReport>>(
            method: HttpMethod.GET,
            endPoint: "api/playerreport/rounds",
            params: {
              "From": startDate.toString(),
              "To": endDate.toString(),
              "page": page.toString(),
              "rows": rows.toString(),
              "desc": "true",
              "sort": "CreatedOn",
              "all": "false",
            },
            converter: (json) =>
                ListResponse.fromJson(json, (res) => BetReport.fromJson(res as Map<String, dynamic>)),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<MainWallet>> getWalletBalance() async {
    return await ApiRequestBuilder<MainWallet>(
            method: HttpMethod.GET,
            endPoint: "api/Wallet",
            converter: (json) => MainWallet.fromJson(json),
            consumer: (result) => setRepoValues(() {
                  wallet = result;
                }),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<ReportResponse<AccountReport>>> getAccountReport(
      DateTime startDate, DateTime endDate, int page, int rows, Status status
      /*int orderBy,
      bool isDesc,
      String sortBy,
      bool showAll*/
      ) async {
    return await ApiRequestBuilder<ReportResponse<AccountReport>>(
            method: HttpMethod.GET,
            endPoint: "api/deposit/player/list",
            params: {
              "begincreate": startDate.toString(),
              "endcreate": endDate.toString(),
              "Page": page.toString(),
              "Rows": rows.toString(),
              "status": (status == null || status == Status.All) ? null : status.getJson().toString(),
              "IsDesc": "true",
              "SortBy": "CreatedOn",
              "ShowAll": "false",
              "OrderBy": "1"
            },
            converter: (json) =>
                ReportResponse.fromJson(json, (res) => AccountReport.fromJson(res as Map<String, dynamic>)),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<ReportResponse<AccountReport>>> getWithdrawReport(
      DateTime startDate, DateTime endDate, int page, int rows, Status status) async {
    return await ApiRequestBuilder<ReportResponse<AccountReport>>(
            method: HttpMethod.GET,
            endPoint: "api/withdraw/player/list",
            params: {
              "begincreate": startDate.toString(),
              "endcreate": endDate.toString(),
              "Page": page.toString(),
              "Rows": rows.toString(),
              "status": (status == null || status == Status.All) ? null : status.getJson().toString(),
              "IsDesc": "true",
              "SortBy": "CreatedOn",
              "ShowAll": "false",
              "OrderBy": "1"
            },
            converter: (json) =>
                ReportResponse.fromJson(json, (res) => AccountReport.fromJson(res as Map<String, dynamic>)),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<ReportResponse<TransferReport>>> getTransferReport(
    DateTime startDate,
    DateTime endDate,
    int page,
    int rows,
  ) async {
    return await ApiRequestBuilder<ReportResponse<TransferReport>>(
            method: HttpMethod.GET,
            endPoint: "api/game/balance/list",
            params: {
              "beginrecord": startDate.toString(),
              "endrecord": endDate.toString(),
              "Page": page.toString(),
              "Rows": rows.toString(),
              "OrderBy": "1",
              "SortBy": "BalanceTime",
              "ShowAll": "false",
              "IsDesc": "true"
            },
            converter: (json) =>
                ReportResponse.fromJson(json, (res) => TransferReport.fromJson(res as Map<String, dynamic>)),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<List<BrandCommunication>>> getBrandCommunication() async {
    return await ApiRequestBuilder<List<BrandCommunication>>(
      method: HttpMethod.GET,
      endPoint: "api/brandcommunication",
      converter: (json) => (json as List<dynamic>).map((e) => BrandCommunication.fromJson(e)).toList(),
      jwtRefresher: jwtAuth,
      isAuthorization: false,
    ).execute();
  }

  Future<EventResult> getApiErrorLocalization() async {
    return await ApiRequestBuilder(
            method: HttpMethod.GET,
            endPoint: "api/localization",
            // converter: (json) => json,
            consumer: (result) => setRepoValues(() {
                  apiError = result;
                }),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<LiveChat>> getLiveChatUrl() async {
    return await ApiRequestBuilder<LiveChat>(
      method: HttpMethod.GET,
      endPoint: "api/brandlivechat",
      converter: (json) => LiveChat.fromJson(json),
      jwtRefresher: jwtAuth,
      isAuthorization: false,
    ).execute();
  }

  Future<EventResult<bool>> getAutoTransferValue() async {
    return await ApiRequestBuilder<bool>(
            method: HttpMethod.GET, endPoint: "api/player/game/auto-transfer", jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> setAutoTransferValue() async {
    return await ApiRequestBuilder<dynamic>(
            method: HttpMethod.POST, endPoint: "api/player/game/auto-transfer", jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<ReportResponse2<PromotionReport>>> getPromotionReport(
      DateTime startDate,
      DateTime endDate,
      int page,
      int rows,
      ) async {
    return await ApiRequestBuilder<ReportResponse2<PromotionReport>>(
        method: HttpMethod.GET,
        endPoint: "api/playerpromotion/joined",
        params: {
          "From": startDate.toString(),
          "To": endDate.toString(),
          "page": page.toString(),
          "rows": rows.toString(),
          "sort": "promotionName",
          "all": "false",
          "desc": "true"
        },
        converter: (json) =>
            ReportResponse2.fromJson(json, (res) => PromotionReport.fromJson(res as Map<String, dynamic>)),
        jwtRefresher: jwtAuth)
        .execute();
  }
}

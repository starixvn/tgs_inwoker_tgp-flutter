
import 'package:tgp_flutter/entity/response/check_username_response.dart';
import 'package:tgp_flutter/entity/response/edit_password_response.dart';
import 'package:tgp_flutter/entity/response/get_transaction_response.dart';
import 'package:tgp_flutter/entity/response/login_response.dart';
import 'package:tgp_flutter/entity/response/register_response.dart';
import 'package:tgp_flutter/entity/bet_transaction.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/entity/wallet.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/network/services/api_service.dart';

import 'base_repository.dart';

class UserRepository extends BaseRepository{
  static UserRepository _singleton;
  UserProfile userProfile;
  Wallet wallet;

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
        }, false);
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
        },false);
    return resolveResponse(response,(json) => LoginResponse.fromJson(json));
  }

  Future<EventResult<CheckUsernameResponse>> checkUsername(String username) async{
    var response = await apiGet(
        "api/player/checkUsername",
        content:{
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

  Future<EventResult<EditPasswordResponse>> editPassword(String oldPassword, String newPassword) async{
    var response = await apiPut(
        "api/player/password",
        {
          "oldpwd": oldPassword,
          "newpwd": newPassword,
        });
    return resolveResponse(response,(json) => EditPasswordResponse.fromJson(json));
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
        content:{
          "id": id,
        });
    return resolveResponse(response,(json) => json as dynamic);
  }

  Future<EventResult<GetTransactionResponse<BetTransaction>>> getTransaction(
      DateTime startDate,
      DateTime endDate,
      int page,
      int rows,
      /*int orderBy,
      bool isDesc,
      String sortBy,
      bool showAll*/
      ) async{
    var response = await apiGet(
        "api/Player/report/rounds",
        content: {
          "From":startDate.toString(),
          "To":endDate.toString(),
          "Page":page.toString(),
          "Rows":rows.toString(),
          /*"OrderBy":orderBy.toString(),
          "IsDesc":isDesc.toString(),
          "SortBy":sortBy,
          "ShowAll":showAll.toString(),*/
        });

    return resolveReportRoundResponse(response, (json) =>
        GetTransactionResponse.fromJson(json,(res)=>
            BetTransaction.fromJson(res)
        )
    );
  }

  Future<EventResult<Wallet>> getWalletBalance() async{
    var response = await apiGet(
        "api/Wallet");
    return resolveBaseResponse(response,(json) =>
        Wallet.fromJson(json),
            (result) => wallet = result
    );
  }
}
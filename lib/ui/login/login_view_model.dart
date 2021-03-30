import 'package:flutter/material.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/language.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();
  var logoutApiState, getAllWalletState;

  @override
  List<BaseRepository> get repoList => [userRepo];

  String token;
  EventResult loginApiState, registerApiState, checkUsernameApiState;
  bool isUsernameExist = false;

  login(String username, String password, bool rememberMe)async{
    setLoading();
    loginApiState = await userRepo.login(username, password);
    if(loginApiState.isSuccess){
      token = loginApiState.result.token;
      print(token);
      savePreferences(username, password, rememberMe);
      getUserInfo();
    }
    setLoading(false);
    return loginApiState;
  }

  register(
      String username,
      String password,
      String rpassword,
      String currency,
      [String invitationCode]
      ) async {
    setLoading();
    var status = await userRepo.register(username, password, rpassword, currency, invitationCode??"");
    if(status.isSuccess){
      registerApiState = await login(username, password, true);
    }
    setLoading(false);
    return registerApiState;
  }

  getUserInfo()async{
    await userRepo.getBasicInfo();
  }

  checkUsername(
      String username
      ) async {
    setLoading();
    checkUsernameApiState = await userRepo.checkUsername(username);
    if(checkUsernameApiState.isSuccess){
      isUsernameExist = checkUsernameApiState.result.isExist;
    }
    setLoading(false);
    return checkUsernameApiState;
  }

  savePreferences( String username, String password, bool rememberMe) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    if(rememberMe){
      prefs.setString("username", username);
      prefs.setString("password", password);
    }
  }

  getUsername() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("username") ?? "";
  }

  getPassword() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("password")?? "";
  }

  resetApiState({bool isLoginApiState = false, isRegisterApiState = false, isCheckUsernameApiState = false,}){
    if (isLoginApiState){
      loginApiState = null;
    }
    if(isRegisterApiState){
      registerApiState = null;
    }
    if(isCheckUsernameApiState){
      registerApiState = null;
    }
  }
}
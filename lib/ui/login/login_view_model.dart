import 'package:flutter/material.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
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
  EventResult loginApiState;
  EventResult registerApiState;
  bool isLoginResultHandled = false;
  bool isRegisterResultHandled = false;

  login(String username, String password, bool rememberMe)async{
    setLoading();
    loginApiState = await userRepo.login(username, password);
    isLoginResultHandled = false;
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
    isRegisterResultHandled = false;
    registerApiState = await userRepo.register(username, password, rpassword, currency, invitationCode??"");
    if(registerApiState.isSuccess){
      token = registerApiState.result;
      savePreferences(username, password, true);
      getUserInfo();
    }
    setLoading(false);
    return registerApiState;
  }

  getUserInfo()async{
    await userRepo.getBasicInfo();
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

  markAsRegisterResultHandled(){
    isRegisterResultHandled = true;
  }
  markAsLoginResultHandled(){
    isLoginResultHandled = true;
  }
}
import 'package:flutter/material.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();
  var authApiState;
  String authToken;

  @override
  List<BaseRepository> get repoList => [userRepo];
  get userProfile => userRepo.userProfile;
  bool isNotLogin = false, isExpired = false;

  getAuthToken()async{
    setLoading();
    authApiState = await userRepo.auth();
    if(authApiState.isSuccess){
      authToken = authApiState.result.token;
      savePreferences(authToken);
    }
    setLoading(false);
    return authApiState;
  }

  resumeIfNeed() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token != null) {
      print(token);
      setLoading();
      notifyListeners();
      await userRepo.getBasicInfo();
      setLoading(false);
      if (userProfile == null) isExpired = true;
    }
    else
      isNotLogin = true;
  }

  savePreferences(String authToken) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("auth_token", authToken);
  }
}
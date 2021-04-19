import 'package:flutter/material.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();
  var authApiState;

  @override
  List<BaseRepository> get repoList => [userRepo];

  getAuthToken()async{
    setLoading();
    authApiState = await userRepo.auth();
    setLoading(false);
    return authApiState;
  }

}
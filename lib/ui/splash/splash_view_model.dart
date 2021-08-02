import 'package:flutter/material.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:shared_api/network/event_result.dart';
import 'package:shared_api/repository/base_repository.dart';
import 'package:shared_api/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/environment_config.dart';

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
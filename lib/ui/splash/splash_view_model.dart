import 'package:flutter/material.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/environment_config.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewModel extends BaseViewModel {
  final contentRepo = ContentRepository.getSingleton();
  final userRepo = UserRepository.getSingleton();
  var authApiState, getLanguageApiState, getBrandLogoApiState;

  @override
  List<BaseRepository> get repoList => [];

  get brandLogoUrl => contentRepo.brandLogo?.mobileUrl;

  getAuthToken() async {
    setLoading();
    authApiState = await userRepo.auth();
    setLoading(false);
    return authApiState;
  }

  getLanguageOption() async {
    setLoading();
    getLanguageApiState = await contentRepo.getLanguageOption();
    if (getLanguageApiState.isSuccess) {}
    setLoading(false);
    return getLanguageApiState;
  }

  getBrandLogo() async {
    setLoading();
    getBrandLogoApiState = await contentRepo.getBrandLogo();
    setLoading(false);
    return getBrandLogoApiState;
  }

  getApiError() async {
    await userRepo.getApiErrorLocalization();
  }
}
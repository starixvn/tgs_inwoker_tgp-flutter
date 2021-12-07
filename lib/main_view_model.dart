import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/language_option.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';
import 'package:tgp_flutter/repository/wallet_repository.dart';

class MainViewModel extends BaseViewModel {
  final contentRepo = ContentRepository.getSingleton();
  final userRepo = UserRepository.getSingleton();
  final walletRepo = WalletRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [];

  bool isNotLogin = false, isExpired = false;
  var authApiState, getLanguageApiState, getBrandLogoApiState, autoLoginApiState, getBasicInfoApiState;
  double gameBalance = 0.0;
  double? totalBalance;

  get brandLogoUrl => contentRepo.brandLogo?.mobileUrl;

  get balance => userRepo.wallet?.main;

  get userProfile => userRepo.userProfile;

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

  resumeIfNeed() async {
    setLoading();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token != null) {
      print(token);
      await getUserInfo();
      if (userProfile == null) await autoLogin();
      print("Token: " + token);
      print("Authorization: " + prefs.getString("auth_token")!);
    } else
      isNotLogin = true;
    setLoading(false);
    notifyListeners();
  }

  getUserInfo() async {
    setLoading();
    getBasicInfoApiState = await userRepo.getBasicInfo();
    if (getBasicInfoApiState.isSuccess) {
      print("111");
    }
    setLoading(false);
    return getBasicInfoApiState;
  }

  autoLogin() async {
    setLoading();
    autoLoginApiState = await userRepo.login(await getUsername(), await getPassword());
    if (autoLoginApiState.isSuccess) {
      savePreferences(autoLoginApiState.result.token);
      getUserInfo();
    }
    setLoading(false);
    return autoLoginApiState;
  }

  savePreferences(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("username") ?? "";
  }

  getPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("password") ?? "";
  }
}

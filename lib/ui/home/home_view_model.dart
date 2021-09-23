import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/announcement.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/game_type.dart';
import 'package:tgp_flutter/entity/home_banner.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/repository/wallet_repository.dart';

class HomeViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();
  final walletRepo = WalletRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [userRepo, contentRepo];

  get userProfile => userRepo.userProfile;

  get brandLogoUrl => contentRepo.brandLogo?.mobileUrl;

  get balance => userRepo.wallet.main;
  bool isNotLogin = false, isExpired = false;
  var getWalletBalanceApiState,
      getBasicInfoApiState,
      getAnnouncementApiState,
      getApiErrorLocalizationApiState,
      getBannerApiState;
  Announcement announcement;
  double gameBalance = 0.0, totalBalance;
  List<HomeBanner> bannerList;

  resumeIfNeed() async {
    setLoading();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token != null) {
      print(token);
      await getUserInfo();
      await userRepo.getWalletBalance();
      await _computeTotalBalance();
      if (userProfile == null) isExpired = true;
      print("Token: " + token);
      print("Authorization: " + prefs.getString("auth_token"));
    } else
      isNotLogin = true;
    setLoading(false);
    notifyListeners();
  }

  markIsNotLogin() {
    isNotLogin = false;
  }

  getAnnouncement() async {
    setLoading();
    getAnnouncementApiState = await contentRepo.getAnnouncement();
    if (getAnnouncementApiState.isSuccess) {
      if (getAnnouncementApiState.result.isEmpty)
        announcement = getAnnouncementApiState.result;
      else
        announcement = getAnnouncementApiState.result?.first;
    }
    setLoading(false);
    return getAnnouncementApiState;
  }

  getApiError() async {
    await userRepo.getApiErrorLocalization();
  }

  _computeTotalBalance() async {
    var gameList = contentRepo.gameProviderList.where((element) => element.transferWallet == true);

    var task = <Future>[];
    gameList.forEach((game) {
      task.add(_getGameWalletBalance(game));
    });
    await Future.wait(task);
    totalBalance = balance + gameBalance;
    notifyListeners();
  }

  _getGameWalletBalance(GameProvider game) async {
    var state = await walletRepo.getGameWallet(game.code);
    if (state.isSuccess) {
      gameBalance += state.result.balance;
    }
    notifyListeners();
  }

  getBanner() async {
    setLoading();
    getBannerApiState = await contentRepo.getBanner();
    if (getBannerApiState.isSuccess) {
      bannerList = getBannerApiState.result;
    }
    setLoading(false);
    return getBannerApiState;
  }

  getUserInfo() async {
    setLoading();
    getBasicInfoApiState = await userRepo.getBasicInfo();
    setLoading(false);
    return getBasicInfoApiState;
  }
}

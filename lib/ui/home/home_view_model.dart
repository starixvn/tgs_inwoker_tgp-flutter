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

  get balance => userRepo.wallet?.main;
  bool isNotLogin = false, isExpired = false;
  var getBasicInfoApiState, getAnnouncementApiState, getApiErrorLocalizationApiState, getBannerApiState, loginApiState;
  String? announcement;
  Announcement? firstAnnouncement;
  double? gameBalance;
  double? totalBalance;
  List<HomeBanner>? bannerList;

  resumeIfNeed() async {
    setLoading();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token != null) {
      print(token);
      await autoLogin();
      await getUserInfo();

      if (userProfile == null) isExpired = true;
      print("Token: " + token);
      print("Authorization: " + prefs.getString("auth_token")!);
    } else
      isNotLogin = true;
    setLoading(false);
    notifyListeners();
  }

  getTotalBalance() async{
    setLoading();
    await userRepo.getWalletBalance();
    await _computeTotalBalance();
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
      List<Announcement> _list = getAnnouncementApiState.result;
      if (_list.isEmpty)
        announcement = "";
      else {
        firstAnnouncement = _list.first;
        announcement = _getAnnouncementContent(_list.first);
        if (_list.length != 1) {
          for (var i = 1; i < _list.length; i++) {
            announcement = announcement! + " " + _getAnnouncementContent(_list[i]);
          }
        }
      }
    }
    setLoading(false);
    return getAnnouncementApiState;
  }

  _getAnnouncementContent(Announcement text) {
    if (text.localization?.content?.isNotEmpty ?? false)
      return text.localization?.content;
    else if (text.content?.isNotEmpty ?? false)
      return text.content;
    else
      return "";
  }

  _computeTotalBalance() async {
    var gameList = contentRepo.gameProviderList!.where((element) => element.transferWallet == true);

    var task = <Future>[];
    gameList.forEach((game) {
      task.add(_getGameWalletBalance(game));
    });
    await Future.wait(task);
    totalBalance = (balance ?? 0.0) + (gameBalance ?? 0.0);
    notifyListeners();
  }

  _getGameWalletBalance(GameProvider game) async {
    var state = await walletRepo.getGameWallet(game.code);
    if (state.isSuccess) {
      gameBalance = (gameBalance ?? 0.0) + state.result!.balance!;
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

  autoLogin() async {
    setLoading();
    loginApiState = await userRepo.login(await getUsername(), await getPassword());
    if (loginApiState.isSuccess) {
      getUserInfo();
      // getWalletBalance();
    }
    setLoading(false);
    return loginApiState;
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

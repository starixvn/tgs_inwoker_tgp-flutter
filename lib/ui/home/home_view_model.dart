import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/announcement.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/game_type.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [userRepo, contentRepo];

  get userProfile => userRepo.userProfile;

  get wallet => userRepo.wallet;
  bool isNotLogin = false, isExpired = false;
  var getWalletBalanceApiState, getBasicInfoApiState, getAnnouncementApiState;
  Announcement announcement;

  resumeIfNeed() async {
    setLoading();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token != null) {
      print(token);
      await userRepo.getBasicInfo();
      await userRepo.getWalletBalance();
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
      announcement = getAnnouncementApiState.result.first;
    }
    setLoading(false);
    return getAnnouncementApiState;
  }
}

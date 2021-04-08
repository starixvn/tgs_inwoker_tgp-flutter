import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/game_type.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [userRepo];
  get userProfile => userRepo.userProfile;
  bool isNotLogin = false, isExpired = false;


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
      print("Token: "+token);
    }
    else isNotLogin = true;
  }

  markIsNotLogin(){
    isNotLogin=false;
  }
}
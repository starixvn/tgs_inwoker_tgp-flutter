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
  final contentRepo = ContentRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [userRepo, contentRepo];
  get userProfile => userRepo.userProfile;
  bool isNotLogin = false, isExpired = false;
  EventResult getGameProviderApiState, getGameApiState, getGameUrlApiState;
  List<GameProvider> gameProviderList;
  List<List<GameType>> gameTypeList;
  List<List<Game>> gameList, allGameList;


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
    else
      isNotLogin = true;
  }

  markIsNotLogin(){
    isNotLogin=false;
  }

  getGameProviderList() async{
    setLoading();
    getGameProviderApiState = await contentRepo.getGameProviderList();
    if(getGameProviderApiState.isSuccess){
      gameProviderList = getGameProviderApiState.result;
      getGameTypeList();
    }
    setLoading(false);
    return getGameProviderApiState;
  }

  getGameTypeList(){
    List<List<GameType>> list = [];
    gameProviderList.forEach((element) {
      list.add(element.gameTypes);
    });
    gameTypeList = list;
    print(gameTypeList);
  }

  getGameList(String gamePlatformCode, int gameType) async{
    setLoading();
    getGameApiState = await contentRepo.getGameList(gamePlatformCode, gameType);
    if(getGameApiState.isSuccess){
      gameList = getGameApiState.result;
      print("=------");
      print(gameList);
    }
    setLoading(false);
    return getGameApiState;
  }

  getAnnouncement() async{

  }

  getGameUrl(String gamePlatformCode, int gameId)async{
    setLoading();
    getGameUrlApiState = await contentRepo.getGameUrl(gamePlatformCode, gameId);
    setLoading(false);
    return getGameUrlApiState;
  }
}
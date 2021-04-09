import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/game_type.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GameViewModel extends BaseViewModel{
  final contentRepo = ContentRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [contentRepo];
  EventResult getGameApiState, getGameUrlApiState;
  List<GameProvider> gameProviderList;
  List<List<GameType>> gameTypeList;
  List<List<Game>> gameList;
  List<List<Game>> list = [];
  var url;


  getAllGameList(){
    var gamePlatformlist = [
      {
        "id":"SBO",
        "code":"1"
      },
      {
        "id":"HABA",
        "code":"15"
      },
      {
        "id":"HABA",
        "code":"16"
      },
    ];
    gamePlatformlist.forEach((element) {
      getGameList(element["id"], int.parse(element["code"]));
    });
  }

  getGameList(String gamePlatformCode, int gameType) async{
    setLoading();
    getGameApiState = await contentRepo.getGameList(gamePlatformCode, gameType);
    if(getGameApiState.isSuccess){
      list.add(getGameApiState.result);
    }
    gameList = list;
    setLoading(false);
    return getGameApiState;
  }

  getAnnouncement() async{

  }

  getGameUrl(String gamePlatformCode, int gameId)async{
    setLoading();
    getGameUrlApiState = await contentRepo.getGameUrl(gamePlatformCode, gameId);
    if(getGameUrlApiState.isSuccess){
      url = getGameUrlApiState.result.url;
    }
    setLoading(false);
    return getGameUrlApiState;
  }
}
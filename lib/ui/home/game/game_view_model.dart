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
  EventResult getGameApiState, getGameUrlApiState, getGameProviderListApiState;
  List<GameProvider> gameProviderList;
  List<List<GameType>> gameTypeList;
 List<Game> gameList;
  var url;

  getGameProviderList() async{
    setLoading();
    getGameProviderListApiState = await contentRepo.getGameProviderList();
    if(getGameProviderListApiState.isSuccess){
      gameProviderList = getGameProviderListApiState.result;
    }
    setLoading(false);
    return getGameProviderListApiState;
  }

  getGameList(String gamePlatformCode, int gameType) async{
    setLoading();
    getGameApiState = await contentRepo.getGameList(gamePlatformCode, gameType);
    if(getGameApiState.isSuccess){
      gameList = getGameApiState.result;
    }
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
import 'dart:math';

import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider2.dart';
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
  List<List<GameType>> gameTypeList;
  List<Game> _gameList, filteredGameList;
  var mCategory=0, mPlatform, mSearchQuery="";
  var url;
  List<GameProvider2> platformList, gameProviderList = [];

  get recommendGameList => _getRecommendGameList();

  getGameProviderList() async{
    setLoading();
    getGameProviderListApiState = await contentRepo.getGameProviderList();
    if(getGameProviderListApiState.isSuccess){
      getGameProviderListApiState.result.forEach((e) {
        e.gameTypes.forEach((element) {
          if(!(element == GameType.VirtualSports || element == GameType.VirtualSportsLobby)){
            gameProviderList.add(GameProvider2(element, e.code, e.name, e.description, e.status));
          }
        });
      });
    }
    setLoading(false);
    return getGameProviderListApiState;
  }

  getGameList(String gamePlatformCode, GameType gameType) async{
    setLoading();
    getGameApiState = await contentRepo.getGameList(gamePlatformCode, gameType);
    if(getGameApiState.isSuccess){
      _gameList = getGameApiState.result;
      mPlatform = gamePlatformCode;
      filter();
    }
    setLoading(false);
    return getGameApiState;
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

  _getRecommendGameList(){
    if(_gameList != null)
    return _gameList.where((element) => element.tag.isRecommend == true).take(6).toList();
    else
      return [];
  }

  filter({int category, String platform, String searchQuery}){
    if(category != null) mCategory = category;
    if(platform != null) mPlatform = platform;
    if(searchQuery != null) mSearchQuery = searchQuery;

    filteredGameList = _filterSearch(_filterTab(_filterCategory()));
    notifyListeners();
  }

  _filterCategory() {
    switch (mCategory) {
      case 0:
      //all game list
        return _gameList;
        break;
      case 1:
      //new game list
        var list = _gameList.where((element) => element.tag.isNew == true).toList();
        return list;
        break;
      case 2:
      //hot game list
        var list = _gameList.where((element) => element.tag.isHot == true).toList();
        return list;
        break;
      default:
        return _gameList;
        break;
    }
  }

  _filterTab(List<Game> gameList){
    if(mPlatform ==null || mPlatform.isEmpty){
      return gameList;
    }
    else{
      var list = gameList.where((element) => element.gamePlatformCode == mPlatform).toList();
      return list;
    }
  }

  _filterSearch(List<Game> gameList){
    if(mSearchQuery ==null || mSearchQuery.isEmpty){
      return gameList;
    }
    else{
      var list = gameList.where((element) => element.name.toLowerCase().contains(mSearchQuery.toLowerCase())).toList();
      return list;
    }
  }

  getPlatformList(GameType gameType){
    platformList = gameProviderList.where((element) => element.gameType == gameType).toList();
    notifyListeners();
  }
}
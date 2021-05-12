import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider2.dart';
import 'package:tgp_flutter/entity/game_type.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameViewModel extends BaseViewModel {
  final contentRepo = ContentRepository.getSingleton();
  final userRepo = UserRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [contentRepo];
  EventResult getGameApiState, getGameUrlApiState, getGameProviderListApiState;
  List<Game> _gameList, filteredGameList;
  Map<String, List<Game>> gameListMap = new Map<String, List<Game>>();
  int mCategory = 0;
  String mPlatform, mSearchQuery = "";
  GameType mGameType;
  var url;
  List<GameProvider2> platformList;
  List<List<GameProvider2>> gameProviderList;
  List<GameType> gameTypeList = [
    GameType.Sportsbook,
    GameType.LiveDealerLobby,
    GameType.CardGameLobby,
    GameType.Slot,
    GameType.TableGame,
    GameType.Fishing,
  ];

  get userProfile => userRepo.userProfile;

  get recommendGameList => _getRecommendGameList();

  getGameProviderList() async {
    if (contentRepo.gameProviderList == null) {
      setLoading();
      getGameProviderListApiState = await contentRepo.getGameProviderList();
    }
    if (contentRepo.gameProviderList == null) return;

    List<GameProvider2> list = [];
    contentRepo.gameProviderList.forEach((e) {
      e.gameTypes.forEach((element) {
        if (!(element == GameType.VirtualSports || element == GameType.VirtualSportsLobby)) {
          list.add(GameProvider2(element, e.code, e.name, e.description, e.status));
        }
      });
    });
    gameProviderList = gameTypeList.map((type) =>
         list.where((element) => element.gameType == type).toList(),
    ).toList();
    // if (getGameProviderListApiState.isSuccess) {
    //
    //
    // }
    setLoading(false);
    return getGameProviderListApiState;
  }

  getGameList(String gamePlatformCode, GameType gameType) async {
    setLoading();
    getGameApiState = await contentRepo.getGameList(gamePlatformCode, gameType);
    if (getGameApiState.isSuccess) {
      gameListMap[gamePlatformCode] = getGameApiState.result;
    }
    setLoading(false);
    return getGameApiState;
  }

  getGameUrl(String gamePlatformCode, int gameId) async {
    setLoading();
    getGameUrlApiState = await contentRepo.getGameUrl(gamePlatformCode, gameId);
    if (getGameUrlApiState.isSuccess) {
      url = getGameUrlApiState.result.url;
    }
    setLoading(false);
    return getGameUrlApiState;
  }

  _getRecommendGameList() {
    if (_gameList != null)
      return _gameList.where((element) => element.tag.isRecommend == true).take(6).toList();
    else
      return <Game>[];
  }

  filter({int category, String searchQuery, String gamePlatformCode, GameType gameType}) async {
    if (gamePlatformCode != null && gameType != null) {
      mGameType = gameType;
      mPlatform = gamePlatformCode;
      await getGameList(gamePlatformCode, gameType);
    }
    if (category != null) mCategory = category;
    if (gamePlatformCode != null) mPlatform = gamePlatformCode;
    if (searchQuery != null) mSearchQuery = searchQuery;

    var platformGameList = await _filterPlatform();
    filteredGameList = _filterSearch(_filterCategory(platformGameList));
    notifyListeners();
  }

  List<Game> _filterCategory(List<Game> gameList) {
    switch (mCategory) {
      case 0:
        //all game list
        return gameList;
      case 1:
        //new game list
        var list = gameList.where((element) => element.tag.isNew == true).toList();
        return list;
      case 2:
        //hot game list
        var list = gameList.where((element) => element.tag.isHot == true).toList();
        return list;
      default:
        return gameList;
    }
  }

  _filterPlatform() async {
    if (mPlatform == "ALL") {
      //get all game list
      List<Game> _list = await _addGameList(_gameList);
      return _list;
    } else {
      if (gameListMap[mPlatform] == null) {
        await getGameList(mPlatform, mGameType);
      }
      return gameListMap[mPlatform];
    }
  }

  _addGameList(List<Game> list) async {
    var task = <Future>[];
    platformList.forEach((platform) {
      if (gameListMap[platform.code] == null) {
        task.add(getGameList(platform.code, mGameType));
      }
    });
    await Future.wait(task);
    return gameListMap.values.expand((element) => element).toList();
  }

  List<Game> _filterSearch(List<Game> gameList) {
    if (mSearchQuery == null || mSearchQuery.isEmpty) {
      return gameList;
    } else {
      var list = gameList.where((element) => element.name.toLowerCase().contains(mSearchQuery.toLowerCase())).toList();
      return list;
    }
  }

  getPlatformList(GameType gameType) {
    List<GameProvider2> list = gameProviderList.expand((e) => e).toList();
    platformList = list.where((element) => element.gameType == gameType).toList();
    notifyListeners();
  }
}

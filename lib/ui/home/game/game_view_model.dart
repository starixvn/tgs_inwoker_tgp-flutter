import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/game_provider2.dart';
import 'package:tgp_flutter/entity/game_type.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
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
  var getGameUrlApiState,
      getGameProviderListApiState,
      getLobbyGameUrlApiState,
      getFavouriteGameApiState,
      setFavouriteGameApiState,
      deleteFavouriteGameApiState,
      getGameApiState,
      getBetConstructHtmlApiState;
  List<Game>? _gameList, filteredGameList;
  Map<String, List<Game>> gameListMap = new Map<String, List<Game>>();
  int mCategory = 0;
  String? mPlatform, mSearchQuery = "";
  GameType? mGameType;
  String? url, lobbyUrl;
  List<GameProvider2>? platformList;
  List<List<GameProvider2>>? gameProviderList;
  List<GameType> gameTypeList = [
    GameType.Sportsbook,
    GameType.ESports,
    GameType.LiveDealerLobby,
    GameType.CardGameLobby,
    GameType.Fishing,
    GameType.LotteryLobby,
    GameType.Slot,
    GameType.EGame,
  ];
  var _context;
  bool isLoading = false;
  bool isGamePlatformInactive = false;
  String? betConstructHtmlText;

  get userProfile => userRepo.userProfile;

  get recommendGameList => _getRecommendGameList();

  get brandLogoUrl => contentRepo.brandLogo?.mobileUrl;

  getGameProviderList({bool isRefresh = false}) async {
    List<GameProvider> _gameProviderList;
    List<GameProvider2> filteredSportList = [];
    if (contentRepo.gameProviderList == null || isRefresh) {
      setLoading();
      getGameProviderListApiState = await contentRepo.getGameProviderList();
      _gameProviderList = getGameProviderListApiState.result;
    } else {
      _gameProviderList = contentRepo.gameProviderList!;
    }
    // if (contentRepo.gameProviderList == null|| isFromChildGame) return;

    _gameProviderList.forEach((e) {
      e.gameTypes.forEach((element) {
        if (!(element == GameType.VirtualSports || element == GameType.VirtualSportsLobby)) {
          filteredSportList.add(GameProvider2(element, e.code, e.name, e.description, e.status));
        }
      });
    });
    gameProviderList = gameTypeList
        .map(
          (type) => filteredSportList.where((element) => element.gameType == type).toList(),
        )
        .toList();

    setLoading(false);
    return getGameProviderListApiState;
  }

  getGameList(String gamePlatformCode, GameType gameType) async {
    setLoading();
    var apiState = await contentRepo.getGameList(gamePlatformCode, gameType);
    if (apiState.isSuccess) {
      if (apiState.result!.isEmpty) {
        getGameApiState = apiState;
        await getPlatformList(gameType);
        isGamePlatformInactive = true;
        mPlatform = "ALL";
        await filter(gamePlatformCode: mPlatform!);
      } else {
        gameListMap[gamePlatformCode] = apiState.result!;
        if (gameType == GameType.Slot || gameType == GameType.EGame || gameType == GameType.Fishing)
          await _getFavoriteGame(gameType).then((_apiState) {
            if (_apiState.result.isNotEmpty) {
              getGameApiState = _apiState;
            } else {
              getGameApiState = apiState;
            }
          });
      }
    }
    setLoading(false);
    return getGameApiState;
  }

  getGameUrl(String gamePlatformCode, int gameId, String _lobbyUrl) async {
    setLoading();
    getGameUrlApiState = await contentRepo.getGameUrl(gamePlatformCode, gameId, _lobbyUrl);
    if (getGameUrlApiState.isSuccess) {
      url = getGameUrlApiState.result.url;
    }
    setLoading(false);
    return getGameUrlApiState;
  }

  getLobbyGameUrl(String gamePlatformCode, GameType gameType, String _lobbyUrl) async {
    setLoading();
    getLobbyGameUrlApiState = await contentRepo.getLobbyGameUrl(gamePlatformCode, gameType, _lobbyUrl);
    if (getLobbyGameUrlApiState.isSuccess) {
      url = getLobbyGameUrlApiState.result.url;
    }
    setLoading(false);
    return getLobbyGameUrlApiState;
  }

  _getRecommendGameList() {
    if (_gameList != null)
      return _gameList!.where((element) => element.tag.isRecommend == true).take(6).toList();
    else
      return <Game>[];
  }

  filter({
    BuildContext? context,
    int? category,
    String? searchQuery,
    String? gamePlatformCode,
    GameType? gameType,
  }) async {
    if (context != null) _context = context;
    if (gamePlatformCode != null && gameType != null) {
      mGameType = gameType;
      mPlatform = gamePlatformCode;
      await getGameList(gamePlatformCode, gameType);
    }
    if (category != null) mCategory = category;
    if (gamePlatformCode != null) mPlatform = gamePlatformCode;
    if (searchQuery != null) mSearchQuery = searchQuery;

    List<Game> platformGameList = await _filterPlatform();
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
      case 3:
        //favorite game list
        var list = gameList.where((element) => element.isFavourite == true).toList();
        return list;
      default:
        return gameList;
    }
  }

  Future<List<Game>> _filterPlatform() async {
    if (mPlatform == "ALL") {
      //get all game list
      List<Game> _list = await _addGameList(_gameList!);
      return _list;
    } else {
      //if (gameListMap[mPlatform] == null) {
      return await getGameList(mPlatform!, mGameType!).then((apiState) {
        if (apiState.result.isEmpty) {
          List<Game> list = [];
          return list;
        } else
          return gameListMap[mPlatform];
      });
    }
  }

  _addGameList(List<Game> list) async {
    var task = <Future>[];
    platformList!.forEach((platform) {
      if (gameListMap[platform.code] == null) {
        task.add(getGameList(platform.code, mGameType!));
      }
    });
    await Future.wait(task);
    return gameListMap.values.expand((element) => element).toList();
  }

  List<Game> _filterSearch(List<Game> gameList) {
    if (mSearchQuery == null || (mSearchQuery?.isEmpty ?? true)) {
      return gameList;
    } else {
      var list = gameList.where((element) => element.name.toLowerCase().contains(mSearchQuery!.toLowerCase())).toList();
      return list;
    }
  }

  getPlatformList(GameType gameType) async {
    await getGameProviderList(isRefresh: true);
    platformList =
        (gameProviderList!.expand((e) => e).toList()).where((element) => element.gameType == gameType).toList();
    isLoading = false;
    notifyListeners();
    return platformList;
  }

  _getFavoriteGame(GameType gameType) async {
    setLoading();
    getFavouriteGameApiState = await contentRepo.getFavoriteGame(gameType);
    if (getFavouriteGameApiState.isSuccess) {
      List list = getFavouriteGameApiState.result;
      gameListMap.values.forEach((gameList) => gameList.map((game) {
            game.isFavourite = false;
            list.forEach((id) {
              if (game.id == id) game.isFavourite = true;
            });
          }).toList());
    }
    setLoading(false);
    return getFavouriteGameApiState;
  }

  setFavoriteGame(Game game) async {
    setLoading();
    var _apiState = await contentRepo.setFavoriteGame(game.id);
    if (_apiState.isSuccess) {
      setFavouriteGameApiState = await _getFavoriteGame(game.type);
    } else
      setFavouriteGameApiState = _apiState;
    setLoading(false);
    return setFavouriteGameApiState;
  }

  deleteFavoriteGame(Game game) async {
    setLoading();
    var _apiState = await contentRepo.deleteFavoriteGame(game.id);
    if (_apiState.isSuccess) {
      deleteFavouriteGameApiState = await _getFavoriteGame(game.type);
    } else
      deleteFavouriteGameApiState = _apiState;
    setLoading(false);
    return deleteFavouriteGameApiState;
  }

  setLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  setGamePlatformInactiveFalse() {
    isGamePlatformInactive = false;
  }

  getBetConstructHtml() async {
    setLoading();
    getBetConstructHtmlApiState = await contentRepo.getBetConstructHtml();
    if (getBetConstructHtmlApiState.isSuccess) {
      url = getBetConstructHtmlApiState.result;
    }
    setLoading(false);
    return getBetConstructHtmlApiState;
  }
}

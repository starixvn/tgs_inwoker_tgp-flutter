import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_api/entity/announcement.dart';
import 'package:shared_api/entity/game.dart';
import 'package:shared_api/entity/game_provider.dart';
import 'package:shared_api/entity/game_type.dart';
import 'package:shared_api/entity/http_method.dart';
import 'package:shared_api/entity/payment.dart';
import 'package:shared_api/entity/promotion.dart';
import 'package:shared_api/entity/response/game_url_response.dart';
import 'package:shared_api/entity/response/list_response.dart';
import 'package:shared_api/entity/user_profile.dart';
import 'package:shared_api/localizations/language_provider.dart';
import 'package:shared_api/network/api_request_builder.dart';
import 'package:shared_api/network/event_result.dart';
import 'package:shared_api/network/services/api_service.dart';

import 'base_repository.dart';

class ContentRepository extends BaseRepository {
  static ContentRepository _singleton;
  UserProfile userProfile;
  List<GameProvider> gameProviderList;

  static ContentRepository getSingleton() {
    if (_singleton == null) {
      _singleton = ContentRepository();
    }
    return _singleton;
  }

  getLanguage() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var languageCode = _prefs.getString("LANGUAGE_CODE") ?? "en-US";
    if (languageCode == "zh-TW")
      return "zh-CN";
    else
      return languageCode;
  }

  Future<EventResult<List<GameProvider>>> getGameProviderList() async {
    return await ApiRequestBuilder<List<GameProvider>>(
            isAuthorization: false,
            method: HttpMethod.GET,
            endPoint: "api/GameProvider/list",
            params: {
              "platformtype": "1",
              "language": await getLanguage(),
              "currency": "CNY",
            },
            converter: (json) => (json as List<dynamic>).map((e) => GameProvider.fromJson(e)).toList(),
            consumer: (result) => setRepoValues(() {
                  gameProviderList = result;
                }),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<List<Game>>> getGameList(String gamePlatformCode, GameType gameType) async {
    return await ApiRequestBuilder<List<Game>>(
            isAuthorization: false,
            method: HttpMethod.GET,
            endPoint: "api/Game/list",
            params: {
              "gpcode": gamePlatformCode,
              "gametypes": gameType.getJsonValue.toString(),
              "platformtype": "1",
              "language": await getLanguage(),
              "currency": "CNY"
            },
            converter: (json) => (json as List<dynamic>).map((e) => Game.fromJson(e)).toList(),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<GameUrlResponse>> getGameUrl(String gamePlatformCode, int gameId, String lobbyUrl) async {
    return await ApiRequestBuilder<GameUrlResponse>(
            method: HttpMethod.POST,
            endPoint: "api/Game/geturl",
            params: {
              "gpcode": gamePlatformCode,
              "gid": gameId.toString(),
              "language": await getLanguage(),
              "extends": {"lobbyurl": lobbyUrl}
            },
            converter: (json) => GameUrlResponse.fromJson(json),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<GameUrlResponse>> getLobbyGameUrl(
      String gamePlatformCode, GameType gameType, String lobbyUrl) async {
    return await ApiRequestBuilder<GameUrlResponse>(
            method: HttpMethod.POST,
            endPoint: "api/Game/lobby/geturl",
            params: {
              "gpcode": gamePlatformCode,
              "gtype": gameType.getJsonValue,
              "language": await getLanguage(),
              "extends": {"lobbyurl": lobbyUrl}
            },
            converter: (json) => GameUrlResponse.fromJson(json),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<List<Announcement>>> getAnnouncement() async {
    return await ApiRequestBuilder<List<Announcement>>(
            method: HttpMethod.GET,
            isAuthorization: false,
            endPoint: "api/announcement/list/${await getLanguage()}",
            converter: (json) => (json as List<dynamic>).map((e) => Announcement.fromJson(e)).toList(),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<ListResponse<Promotion>>> getPromotionList(int page, int rows, bool desc, bool all) async {
    return await ApiRequestBuilder<ListResponse<Promotion>>(
            method: HttpMethod.GET,
            endPoint: "api/promotion/${await getLanguage()}",
            params: {
              "page": page.toString(),
              "rows": rows.toString(),
              "desc": desc.toString(),
              //"sort":"",
              "all": all.toString(),
            },
            converter: (json) => ListResponse.fromJson(json, (res) => Promotion.fromJson(res)),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> joinPromotion(String id) async {
    return await ApiRequestBuilder<dynamic>(
            method: HttpMethod.POST, endPoint: "api/promotion/$id/join", jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<ListResponse<Promotion>>> getPlayerPromotionList(int page, int rows, bool desc, bool all) async {
    return await ApiRequestBuilder<ListResponse<Promotion>>(
            method: HttpMethod.GET,
            endPoint: "api/playerpromotion/${await getLanguage()}",
            params: {
              "page": page.toString(),
              "rows": rows.toString(),
              "desc": desc.toString(),
              "all": all.toString(),
            },
            converter: (json) => ListResponse.fromJson(json, (res) => Promotion.fromJson(res)),
            jwtRefresher: jwtAuth)
        .execute();
  }
}

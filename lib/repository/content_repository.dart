import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/entity/announcement.dart';
import 'package:tgp_flutter/entity/brand_logo.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/game_type.dart';
import 'package:tgp_flutter/entity/home_banner.dart';
import 'package:tgp_flutter/entity/http_method.dart';
import 'package:tgp_flutter/entity/language_option.dart';
import 'package:tgp_flutter/entity/payment.dart';
import 'package:tgp_flutter/entity/promotion.dart';
import 'package:tgp_flutter/entity/response/game_url_response.dart';
import 'package:tgp_flutter/entity/response/list_response.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/environment_config.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/network/api_request_builder.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/network/services/api_service.dart';

import 'base_repository.dart';

class ContentRepository extends BaseRepository {
  static ContentRepository? _singleton;
  List<GameProvider>? gameProviderList;
  List<LanguageOption>? languageOptionList;
  List<Promotion>? promotionList;
  BrandLogo? brandLogo;

  static ContentRepository getSingleton() {
    if (_singleton == null) {
      _singleton = ContentRepository();
    }
    return _singleton!;
  }

  getLanguage() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var languageCode = _prefs.getString("LANGUAGE_CODE") ?? "en-US";
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
              "currency": EnvironmentConfig.currency,
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
              "currency": EnvironmentConfig.currency
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

  Future<EventResult<ListResponse<Promotion>>> getPromotionList(
      int page, int rows, bool desc, bool all, bool isUserProfileNotNull) async {
    return await ApiRequestBuilder<ListResponse<Promotion>>(
            method: HttpMethod.GET,
            endPoint: isUserProfileNotNull
                ? "api/promotion/${await getLanguage()}"
                : "api/playerpromotion/${await getLanguage()}",
            params: {
              "page": page.toString(),
              "rows": rows.toString(),
              "desc": desc.toString(),
              //"sort":"",
              "all": all.toString(),
            },
            converter: (json) => ListResponse.fromJson(json, (res) => Promotion.fromJson(res as Map<String, dynamic>)),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> joinPromotion(String id) async {
    return await ApiRequestBuilder<dynamic>(
            method: HttpMethod.POST, endPoint: "api/promotion/$id/join", jwtRefresher: jwtAuth)
        .execute();
  }

  /*Future<EventResult<ListResponse<Promotion>>> getPlayerPromotionList(int page, int rows, bool desc, bool all) async {
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
  }*/

  Future<EventResult<List<int>>> getFavoriteGame(GameType? gameType) async {
    return await ApiRequestBuilder<List<int>>(
            method: HttpMethod.GET,
            endPoint: "api/game/favorite/${gameType?.getJsonValue}",
            converter: (json) => json.cast<int>(),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> setFavoriteGame(int? gameId) async {
    return await ApiRequestBuilder<dynamic>(
            method: HttpMethod.PUT,
            endPoint: "api/game/favorite/$gameId",
            //converter: (json) => ListResponse.fromJson(json, (res) => Promotion.fromJson(res)),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> deleteFavoriteGame(int? gameId) async {
    return await ApiRequestBuilder<dynamic>(
            method: HttpMethod.DELETE,
            endPoint: "api/game/favorite/$gameId",
            //converter: (json) => ListResponse.fromJson(json, (res) => Promotion.fromJson(res)),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<List<LanguageOption>>> getLanguageOption() async {
    return await ApiRequestBuilder<List<LanguageOption>>(
            method: HttpMethod.GET,
            endPoint: "api/brandlanguage",
            converter: (json) => (json as List<dynamic>).map((e) => LanguageOption.fromJson(e)).toList(),
            consumer: (result) => setRepoValues(() {
                  languageOptionList = result;
                }),
            jwtRefresher: jwtAuth,
            isAuthorization: false)
        .execute();
  }

  Future<EventResult<List<HomeBanner>>> getBanner() async {
    return await ApiRequestBuilder<List<HomeBanner>>(
      method: HttpMethod.GET,
      endPoint: "api/banner",
      converter: (json) => (json as List<dynamic>).map((e) => HomeBanner.fromJson(e)).toList(),
      jwtRefresher: jwtAuth,
      isAuthorization: false,
    ).execute();
  }

  Future<EventResult<BrandLogo>> getBrandLogo() async {
    return await ApiRequestBuilder<BrandLogo>(
      method: HttpMethod.GET,
      endPoint: "api/brand",
      converter: (json) => BrandLogo.fromJson(json),
      jwtRefresher: jwtAuth,
      isAuthorization: false,
      consumer: (result) => setRepoValues(() {
        brandLogo = result;
      }),
    ).execute();
  }

  Future<EventResult<dynamic>> getBetConstructHtml() async {
    return await ApiRequestBuilder<dynamic>(
      method: HttpMethod.GET,
      endPoint: "api/game/bc",
      //converter: (json) => BrandLogo.fromJson(json),
      jwtRefresher: jwtAuth,
      //isAuthorization: false,
      /*consumer: (result) => setRepoValues(() {
        brandLogo = result;
      }),*/
    ).executeWithoutBaseResponse();
  }
}

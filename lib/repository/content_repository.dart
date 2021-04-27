import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/game_type.dart';
import 'package:tgp_flutter/entity/http_method.dart';
import 'package:tgp_flutter/entity/response/game_url_response.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/network/api_request_builder.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/network/services/api_service.dart';

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

  Future<EventResult<List<GameProvider>>> getGameProviderList() async {
    return await ApiRequestBuilder<List<GameProvider>>(
            method: HttpMethod.GET,
            endPoint: "api/GameProvider/list",
            params: {
              "platformtype": "1",
              "language": "en-US",
              "currency": "CNY",
            },
            converter: (json) => (json as List<dynamic>).map((e) => GameProvider.fromJson(e)).toList(),
            consumer: (result) => gameProviderList = result,
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<List<Game>>> getGameList(String gamePlatformCode, GameType gameType) async {
    return await ApiRequestBuilder<List<Game>>(
            method: HttpMethod.GET,
            endPoint: "api/Game/list",
            params: {
              "gpcode": gamePlatformCode,
              "gametypes": gameType.getJsonValue.toString(),
              "platformtype": "1",
              "language": "en-US",
              "currency": "CNY"
            },
            converter: (json) => (json as List<dynamic>).map((e) => Game.fromJson(e)).toList(),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<GameUrlResponse>> getGameUrl(String gamePlatformCode, int gameId) async {
    return await ApiRequestBuilder<GameUrlResponse>(
            method: HttpMethod.GET,
            endPoint: "api/Game/geturl",
            params: {
              "gpcode": gamePlatformCode,
              "gid": gameId.toString(),
              "language": "en-US",
            },
            converter: (json) => GameUrlResponse.fromJson(json),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> getAnnouncement() async {
    return await ApiRequestBuilder<dynamic>(
            method: HttpMethod.GET,
            isAuthorization: false,
            endPoint: "api/Game/list",
            params: {},
            jwtRefresher: jwtAuth)
        .execute();
  }
}

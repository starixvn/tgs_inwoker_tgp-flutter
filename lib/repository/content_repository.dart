
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/response/game_url_response.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
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
    var response = await apiGet(
        "api/GameProvider/list",
        content:{
          "platformtype": "1",
          "language": "en-US",
          "currency": "CNY",
        });
    return resolveBaseResponse(response, (json) {
      return (json as List<dynamic>).map((e) =>
          GameProvider.fromJson(e)
      ).toList();
    }, (result) => gameProviderList = result);
  }

  Future<EventResult<List<Game>>> getGameList(String gamePlatformCode,
      int gameType) async {
    var response = await apiGet(
        "api/Game/list",
        content:{
          "gpcode": gamePlatformCode,
          "gametypes": gameType.toString(),
          "platformtype": "1",
          "language": "en-US",
          "currency": "CNY"
        },
        isAuthorization: false
    );
    return resolveBaseResponse(response, (json) {
      return (json as List<dynamic>).map((e) =>
          Game.fromJson(e)
      ).toList();
    });
  }

  Future<EventResult<GameUrlResponse>> getGameUrl(String gamePlatformCode,
      int gameId) async {
    var response = await apiGet(
        "api/Game/geturl",
        content:{
          "gpcode": gamePlatformCode,
          "gid": gameId.toString(),
          "language": "en-US",
        });
    return resolveResponse(response, (json) => GameUrlResponse.fromJson(json));
  }

  Future<EventResult<String>> getAnnouncement() async {
    var response = await apiGet(
        "api/announcement/list",
      isAuthorization: false
    );
    return resolveOnlyDataResponse(response, (json) => (json as String));
  }
}
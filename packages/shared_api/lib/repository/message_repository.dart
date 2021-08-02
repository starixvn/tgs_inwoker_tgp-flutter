import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_api/entity/game.dart';
import 'package:shared_api/entity/game_provider.dart';
import 'package:shared_api/entity/http_method.dart';
import 'package:shared_api/entity/message.dart';
import 'package:shared_api/entity/response/game_url_response.dart';
import 'package:shared_api/entity/response/list_response.dart';
import 'package:shared_api/entity/user_profile.dart';
import 'package:shared_api/network/api_request_builder.dart';
import 'package:shared_api/network/event_result.dart';
import 'package:shared_api/network/services/api_service.dart';

import 'base_repository.dart';

class MessageRepository extends BaseRepository {
  static MessageRepository _singleton;
  UserProfile userProfile;
  List<GameProvider> gameProviderList;

  static MessageRepository getSingleton() {
    if (_singleton == null) {
      _singleton = MessageRepository();
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

  Future<EventResult<ListResponse<Message>>> getMessageList(int page, int rows) async {
    return await ApiRequestBuilder<ListResponse<Message>>(
            method: HttpMethod.GET,
            endPoint: "api/letter/${await getLanguage()}",
            params: {
              "page": page.toString(),
              "rows": rows.toString(),
            },
            converter: (json) => ListResponse.fromJson(json, (res) => Message.fromJson(res)),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> readMessage(List<String> id) async {
    return await ApiRequestBuilder<dynamic>(
            method: HttpMethod.POST, endPoint: "api/letter", params: id, jwtRefresher: jwtAuth)
        .execute();
  }
}

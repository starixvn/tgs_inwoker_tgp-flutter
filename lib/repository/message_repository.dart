import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/http_method.dart';
import 'package:tgp_flutter/entity/message.dart';
import 'package:tgp_flutter/entity/response/game_url_response.dart';
import 'package:tgp_flutter/entity/response/list_response.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/network/api_request_builder.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/network/services/api_service.dart';

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

  Future<EventResult<ListResponse<Message>>> getMessageList(int page, int rows) async {
    return await ApiRequestBuilder<ListResponse<Message>>(
            method: HttpMethod.GET,
            endPoint: "api/letter",
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

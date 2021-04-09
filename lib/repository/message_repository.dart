
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/response/game_url_response.dart';
import 'package:tgp_flutter/entity/response/message_response.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
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

  Future<EventResult<MessageResponse>> getMessageList(
      int page,
      int rows
      ) async {
    var response = await apiGet(
        "api/letter",
        content:{
          "page": page.toString(),
          "rows": rows.toString(),
        });
    return resolveBaseResponse(response, (json) => MessageResponse.fromJson(json));
  }
}
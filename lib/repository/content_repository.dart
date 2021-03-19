
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/network/services/api_service.dart';

import 'base_repository.dart';

class ContentRepository extends BaseRepository{
  static ContentRepository _singleton;
  UserProfile userProfile;

  static ContentRepository getSingleton(){
    if(_singleton == null){
      _singleton = ContentRepository();
    }
    return _singleton;
  }

}
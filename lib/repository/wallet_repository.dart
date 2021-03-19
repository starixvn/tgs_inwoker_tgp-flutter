
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/network/services/api_service.dart';

import 'base_repository.dart';

class WalletRepository extends BaseRepository{
  static WalletRepository _singleton;
  UserProfile userProfile;

  static WalletRepository getSingleton(){
    if(_singleton == null){
      _singleton = WalletRepository();
    }
    return _singleton;
  }

}
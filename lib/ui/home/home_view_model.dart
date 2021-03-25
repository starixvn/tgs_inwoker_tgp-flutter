import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [userRepo];
  get userProfile => userRepo.userProfile;
  bool isNotLogin = false, isExpired = false;
  var getGameState;

  markIsNotLogin(){
    isNotLogin=false;
  }
}
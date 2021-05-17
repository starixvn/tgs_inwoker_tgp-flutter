
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/main_wallet.dart';
import 'package:tgp_flutter/entity/wallet_response.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileInfoViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [userRepo ];
  get userProfile => userRepo.userProfile;


}
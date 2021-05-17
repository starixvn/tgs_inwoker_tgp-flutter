
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';


class ProfileInfoViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [userRepo ];
  get userProfile => userRepo.userProfile;


}

import 'package:tgp_flutter/base_viewmodel.dart';
 import 'package:api/api.dart';


class ProfileInfoViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [userRepo ];
  get userProfile => userRepo.userProfile;


}
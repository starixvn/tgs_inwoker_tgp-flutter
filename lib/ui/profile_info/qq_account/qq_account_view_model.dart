import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class QQAccountViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();
  var setQQApiState;

  @override
  List<BaseRepository> get repoList => [userRepo];
  get userProfile => userRepo.userProfile;

  setQQAccount(String qq) async{
    setLoading();
    setQQApiState = await userRepo.setQQAccount(qq);
    if(setQQApiState.isSuccess){
      await userRepo.getBasicInfo();
    }
    setLoading(false);
    return setQQApiState;
  }

}
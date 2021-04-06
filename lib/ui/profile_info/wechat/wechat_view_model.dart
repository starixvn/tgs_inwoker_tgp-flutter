import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class WechatViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();
  var setWechatApiState, getBasicInfoApiState;

  @override
  List<BaseRepository> get repoList => [userRepo];
  get userProfile => userRepo.userProfile;

  setWechatAccount(String qq) async{
    setLoading();
    setWechatApiState = await userRepo.setWechatAccount(qq);
    if(setWechatApiState.isSuccess){
      await userRepo.getBasicInfo();
    }
    setLoading(false);
    return setWechatApiState;
  }
}
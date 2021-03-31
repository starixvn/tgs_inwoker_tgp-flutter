import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class WechatViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();
  var updateWechatApiState, getBasicInfoApiState;

  @override
  List<BaseRepository> get repoList => [userRepo];
  get userProfile => userRepo.userProfile;

  /*updateWechatAccount(String wechat) async{
    setLoading();
    updateWechatApiState = await userRepo.updateWechatAccount(wechat);
    setLoading(false);
    return updateWechatApiState;
  }

  getBasicInfo() async{
    setLoading();
    getBasicInfoApiState = await userRepo.getBasicInfo();
    setLoading(false);
    return getBasicInfoApiState;
  }

  resetApiState({bool isUpdateWechatApiState = false, bool isGetBasicInfoApiState = false}){
    if(isUpdateWechatApiState){
      updateWechatApiState = null;
    }
    else if(isGetBasicInfoApiState){
      getBasicInfoApiState = null;
    }
  }*/
}
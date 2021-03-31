import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class QQAccountViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();
  var updateQQApiState, getBasicInfoApiState;

  @override
  List<BaseRepository> get repoList => [userRepo];
  get userProfile => userRepo.userProfile;

  /*updateQQAccount(String qq) async{
    setLoading();
    updateQQApiState = await userRepo.updateQQAccount(qq);
    setLoading(false);
    return updateQQApiState;
  }

  getBasicInfo() async{
    setLoading();
    getBasicInfoApiState = await userRepo.getBasicInfo();
    setLoading(false);
    return getBasicInfoApiState;
  }

  resetApiState({bool isUpdateQQApiState = false, bool isGetBasicInfoApiState = false}){
    if(isUpdateQQApiState){
      updateQQApiState = null;
    }
    else if(isGetBasicInfoApiState){
      getBasicInfoApiState = null;
    }
  }*/
}
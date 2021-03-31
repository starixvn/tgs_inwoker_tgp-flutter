import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/event_type.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class EmailVerificationViewModel extends BaseViewModel{
 // final authRepo = AuthenticationRepository.getSingleton();
  final userRepo = UserRepository.getSingleton();
  var emailVerifyApiState, verifyCodeApiState, getBasicInfoApiState;

  @override
  List<BaseRepository> get repoList => [];
  get userProfile => userRepo.userProfile;

  /*emailVerify(String email, EventType event) async{
    setLoading();
    emailVerifyApiState = await authRepo.emailVerify(email, event);
    setLoading(false);
    return emailVerifyApiState;
  }

  getBasicInfo() async{
    setLoading();
    getBasicInfoApiState = await userRepo.getBasicInfo();
    setLoading(false);
    return getBasicInfoApiState;
  }

  resetApiState({
    bool isEmailVerifyApiState = false,
    bool isVerifyCodeApiState = false,
    bool isGetBasicInfoApiState = false,
  }){
    if(isEmailVerifyApiState){
      emailVerifyApiState = null;
    }else if(isGetBasicInfoApiState){
      getBasicInfoApiState = null;
    }
  }*/
}
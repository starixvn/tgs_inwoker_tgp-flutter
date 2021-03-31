import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/event_type.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class PhoneVerificationViewModel extends BaseViewModel{
  //final authRepo = AuthenticationRepository.getSingleton();
  final userRepo = UserRepository.getSingleton();
  var getSmsCodeApiState, verifyCodeApiState, getBasicInfoApiState;

  @override
  List<BaseRepository> get repoList => [];
  /*get userProfile => userRepo.userProfile;

  getSmsCode(String phone, EventType event) async{
    setLoading();
    getSmsCodeApiState = await authRepo.phoneVerify(phone, event);
    setLoading(false);
    return getSmsCodeApiState;
  }

  verifyCode(String phone, String code, EventType event) async{
    setLoading();
    if(event == EventType.BIND){
      verifyCodeApiState = await userRepo.bindPhone(phone, code);
    }else if(event == EventType.CHECK){
      verifyCodeApiState = await userRepo.resetBindPhoneStepOne(phone, code);
    }else if(event == EventType.REBIND){
      verifyCodeApiState = await userRepo.resetBindPhoneStepTwo(phone, code);
    }
    setLoading(false);
    return verifyCodeApiState;
  }

  getBasicInfo() async{
    setLoading();
    getBasicInfoApiState = await userRepo.getBasicInfo();
    setLoading(false);
    return getBasicInfoApiState;
  }

  resetApiState({
    bool isGetSmsCodeApiState = false,
    bool isVerifyCodeApiState = false,
    bool isGetBasicInfoApiState = false,
  }){
    if(isGetSmsCodeApiState){
      getSmsCodeApiState = null;
    }else if(isVerifyCodeApiState){
      verifyCodeApiState = null;
    }else if(isGetBasicInfoApiState){
      getBasicInfoApiState = null;
    }
  }*/
}
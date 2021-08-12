import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:api/entity/event_type.dart';
 import 'package:api/api.dart';

class PhoneVerificationViewModel extends BaseViewModel{
  final authRepo = AuthenticationRepository.getSingleton();
  final userRepo = UserRepository.getSingleton();
  var phoneVerifyApiState, getSmsCodeApiState;

  @override
  List<BaseRepository> get repoList => [];
  get userProfile => userRepo.userProfile;

  var securityKey;

  getSmsCode(String phone) async{
    setLoading();
    getSmsCodeApiState = await authRepo.phoneVerify(phone);
    if(getSmsCodeApiState.isSuccess){
      securityKey = getSmsCodeApiState.result;
    }
    setLoading(false);
    return getSmsCodeApiState;
  }

  phoneVerify(String verificationCode) async{
    setLoading();
    var _status = await authRepo.verifyCode(securityKey, verificationCode, isPhone: true);
    if(_status.isSuccess){
      phoneVerifyApiState = await userRepo.getBasicInfo();
    }else phoneVerifyApiState = _status;
    setLoading(false);
    return phoneVerifyApiState;
  }
}
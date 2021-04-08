import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/event_type.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class PayPasswordViewModel extends BaseViewModel{
  //final authRepo = AuthenticationRepository.getSingleton();
  final userRepo = UserRepository.getSingleton();
  var updatePayPasswordApiState, resetQuestionApiState,
      getResetWithdrawalPasswordTokenApiState, getBasicInfoApiState;

  @override
  List<BaseRepository> get repoList => [userRepo,];
  get userProfile => userRepo.userProfile;

  /*updateWithdrawPassword(String password, {String oldPassword}) async{
    setLoading();
    updateWithdrawPasswordApiState = await userRepo.updateWithdrawPassword(oldPassword, password);
    setLoading(false);
    return updateWithdrawPasswordApiState;
  }

  resetQuestion(String code) async{
    setLoading();
    resetQuestionApiState = await userRepo.resetWithdrawalPasswordByPhone(code);
    setLoading(false);
    return resetQuestionApiState;
  }

  getResetWithdrawalPasswordToken() async{
    setLoading();
    getResetWithdrawalPasswordTokenApiState = await authRepo.phoneVerify("", EventType.RESET_WITHDRAWAL_PASSWORD);
    setLoading(false);
    return getResetWithdrawalPasswordTokenApiState;
  }

  getBasicInfo() async{
    setLoading();
    getBasicInfoApiState = await userRepo.getBasicInfo();
    setLoading(false);
    return getBasicInfoApiState;
  }

  resetApiState({
    bool isUpdateWithdrawPasswordApiState = false,
    bool isResetQuestionApiState = false,
    bool isGetResetWithdrawalPasswordTokenApiState = false,
    bool isGetBasicInfoApiState = false,
  }){
    if(isUpdateWithdrawPasswordApiState){
      updateWithdrawPasswordApiState = null;
    }else if(isResetQuestionApiState){
      resetQuestionApiState = null;
    }else if(isGetResetWithdrawalPasswordTokenApiState){
      getResetWithdrawalPasswordTokenApiState = null;
    }
    else if(isGetBasicInfoApiState){
      getBasicInfoApiState = null;
    }
  }*/
}
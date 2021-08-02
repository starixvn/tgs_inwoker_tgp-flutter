import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:api_package/entity/event_type.dart';
 import 'package:api_package/api_package.dart';

class SecurityAnswerViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();

  //final authRepo = AuthenticationRepository.getSingleton();
  var getSecurityQuestionApiState,
      updateSecurityQuestionApiState,
      resetQuestionByAnswerApiState,
      resetQuestionApiState,
      getResetQuestionTokenApiState,
      getBasicInfoApiState;

  @override
  List<BaseRepository> get repoList => [userRepo];

  get userProfile => userRepo.userProfile;

/*getSecurityQuestion() async{
    setLoading();
    getSecurityQuestionApiState = await contentRepo.getSecurityQuestion();
    setLoading(false);
    return getSecurityQuestionApiState;
  }

  updateSecurityQuestion(int questionID, String answer, bool isReset) async{
    setLoading();
    if(isReset){
      updateSecurityQuestionApiState = await userRepo.resetSecurityQuestion(questionID, answer);
    }else{
      updateSecurityQuestionApiState = await userRepo.updateSecurityQuestion(questionID, answer);
    }
    setLoading(false);
    return updateSecurityQuestionApiState;
  }

  resetQuestionByAnswer(String answer) async{
    setLoading();
    resetQuestionByAnswerApiState = await userRepo.resetQuestionByAnswer(answer);
    setLoading(false);
    return resetQuestionByAnswerApiState;
  }

  resetQuestion(String code, bool isPhone) async{
    setLoading();
    if(isPhone){
      resetQuestionApiState = await userRepo.resetQuestionByPhone(code);
    }else{
      resetQuestionApiState = await userRepo.resetQuestionByEmail(code);
    }
    setLoading(false);
    return resetQuestionApiState;
  }

  getResetQuestionToken(bool isPhone) async{
    setLoading();
    if(isPhone){
      getResetQuestionTokenApiState = await authRepo.phoneVerify("",EventType.RESET_QUESTION);
    }else{
      getResetQuestionTokenApiState = await authRepo.emailVerify("",EventType.RESET_QUESTION);
    }
    setLoading(false);
    return getResetQuestionTokenApiState;
  }

  getBasicInfo() async{
    setLoading();
    getBasicInfoApiState = await userRepo.getBasicInfo();
    setLoading(false);
    return getBasicInfoApiState;
  }

  resetApiState({
    bool isGetSecurityQuestionApiState = false,
    bool isUpdateSecurityQuestionApiState = false,
    bool isResetQuestionByAnswerApiState = false,
    bool isResetQuestionApiState = false,
    bool isGetResetQuestionTokenApiState = false,
    bool isGetBasicInfoApiState = false
  }){
    if(isGetSecurityQuestionApiState){
      getSecurityQuestionApiState = null;
    }else if(isUpdateSecurityQuestionApiState){
      updateSecurityQuestionApiState = null;
    }else if(isResetQuestionByAnswerApiState){
      resetQuestionByAnswerApiState = null;
    }else if(isResetQuestionApiState){
      resetQuestionApiState = null;
    }else if(isGetResetQuestionTokenApiState){
      getResetQuestionTokenApiState = null;
    } else if(isGetBasicInfoApiState){
      getBasicInfoApiState = null;
    }
  }*/
}

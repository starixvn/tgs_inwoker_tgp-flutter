import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/event_type.dart';
import 'package:tgp_flutter/repository/auth_repository.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class EmailVerificationViewModel extends BaseViewModel{
  final authRepo = AuthenticationRepository.getSingleton();
  final userRepo = UserRepository.getSingleton();
  var getEmailCodeApiState, emailVerifyApiState;

  @override
  List<BaseRepository> get repoList => [];
  get userProfile => userRepo.userProfile;
  var securityKey;

  getEmailCode(String email) async{
    setLoading();
    getEmailCodeApiState = await authRepo.emailVerify(email);
    if(getEmailCodeApiState.isSuccess){
      securityKey = getEmailCodeApiState.result;
    }
    setLoading(false);
    return getEmailCodeApiState;
  }

  emailVerify(String verificationCode) async{
    setLoading();
    emailVerifyApiState = await authRepo.verifyCode(securityKey, verificationCode);
    if(emailVerifyApiState.isSuccess){
      await userRepo.getBasicInfo();
    }
    setLoading(false);
    return emailVerifyApiState;
  }
}
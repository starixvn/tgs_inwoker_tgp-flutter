import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/repository/auth_repository.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class PhoneVerificationViewModel extends BaseViewModel {
  final authRepo = AuthenticationRepository.getSingleton();
  final userRepo = UserRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();
  var submitVerifyCodeApiState, getPhoneVerifyCodeApiState;

  @override
  List<BaseRepository> get repoList => [];

  get userProfile => userRepo.userProfile;

  get brandLogoUrl => contentRepo.brandLogo?.mobileUrl;

  var securityKey;

  getPhoneVerifyCode(String area, String phone) async {
    setLoading();
    getPhoneVerifyCodeApiState = await authRepo.getPhoneVerifyCode(area, phone);
    if (getPhoneVerifyCodeApiState.isSuccess) {
      securityKey = getPhoneVerifyCodeApiState.result;
    }
    setLoading(false);
    return getPhoneVerifyCodeApiState;
  }

  submitVerifyCode(int index, String verificationCode) async {
    setLoading();
    var _status = await authRepo.submitVerifyCode(securityKey, verificationCode, isPhone: true);
    if (_status.isSuccess && index == 1) {
      submitVerifyCodeApiState = await userRepo.getBasicInfo();
    } else
      submitVerifyCodeApiState = _status;
    setLoading(false);
    return submitVerifyCodeApiState;
  }
}

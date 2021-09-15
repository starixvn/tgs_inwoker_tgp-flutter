import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/repository/auth_repository.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  final authRepo = AuthenticationRepository.getSingleton();
  final userRepo = UserRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();
  var getForgotPasswordCodeApiState, resetPasswordApiState;

  @override
  List<BaseRepository> get repoList => [];

  get userProfile => userRepo.userProfile;

  get brandLogoUrl => contentRepo.brandLogo?.mobileUrl;
  var securityKey;

  getForgotPasswordCode(String phone) async {
    setLoading();
    getForgotPasswordCodeApiState = await authRepo.getForgotPasswordCode(phone);
    if (getForgotPasswordCodeApiState.isSuccess) {
      securityKey = getForgotPasswordCodeApiState.result;
    }
    setLoading(false);
    return getForgotPasswordCodeApiState;
  }

  resetPassword(String securityKey, String verificationCode, String newPassword) async {
    setLoading();
    resetPasswordApiState = await authRepo.resetPassword(securityKey, verificationCode, newPassword);
    if (resetPasswordApiState.isSuccess) {}
    setLoading(false);
    return resetPasswordApiState;
  }
}

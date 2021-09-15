import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';


class RealNameVerificationViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();
  var idVerifyApiState;

  @override
  List<BaseRepository> get repoList => [userRepo];
  get userProfile => userRepo.userProfile;
  get brandLogoUrl => contentRepo.brandLogo?.mobileUrl;

  idVerify(String realname, String id) async {
    setLoading();
    var _status = idVerifyApiState = await userRepo.setIdentity(realname, id);
    if (_status.isSuccess) {
      idVerifyApiState = await userRepo.getBasicInfo();
    }else idVerifyApiState = _status;
    setLoading(false);
    return idVerifyApiState;
  }
}
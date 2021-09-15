import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class QQAccountViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();
  var setQQApiState;

  @override
  List<BaseRepository> get repoList => [userRepo];

  get userProfile => userRepo.userProfile;

  get brandLogoUrl => contentRepo.brandLogo?.mobileUrl;

  setQQAccount(String qq) async {
    setLoading();
    var _status = await userRepo.setQQAccount(qq);
    if (_status.isSuccess) {
      setQQApiState = await userRepo.getBasicInfo();
    } else
      setQQApiState = _status;
    setLoading(false);
    return setQQApiState;
  }
}

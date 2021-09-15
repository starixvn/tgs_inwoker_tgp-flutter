import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class WechatViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();
  var setWechatApiState;

  @override
  List<BaseRepository> get repoList => [userRepo];

  get userProfile => userRepo.userProfile;

  get brandLogoUrl => contentRepo.brandLogo?.mobileUrl;

  setWechatAccount(String qq) async {
    setLoading();
    var _status = await userRepo.setWechatAccount(qq);
    if (_status.isSuccess) {
      setWechatApiState = await userRepo.getBasicInfo();
    } else
      setWechatApiState = _status;
    setLoading(false);
    return setWechatApiState;
  }
}

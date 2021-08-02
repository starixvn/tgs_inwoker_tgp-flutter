import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:shared_api/repository/base_repository.dart';
import 'package:shared_api/repository/user_repository.dart';

class WechatViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();
  var setWechatApiState;

  @override
  List<BaseRepository> get repoList => [userRepo];

  get userProfile => userRepo.userProfile;

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

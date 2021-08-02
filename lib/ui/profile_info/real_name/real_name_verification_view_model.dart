import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:shared_api/repository/base_repository.dart';
import 'package:shared_api/repository/user_repository.dart';


class RealNameVerificationViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();
  var idVerifyApiState;

  @override
  List<BaseRepository> get repoList => [userRepo];
  get userProfile => userRepo.userProfile;

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
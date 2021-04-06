import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';


class RealNameVerificationViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();
  var idVerifyApiState;

  @override
  List<BaseRepository> get repoList => [userRepo];
  get userProfile => userRepo.userProfile;

  idVerify(String realname, String id) async {
    setLoading();
    idVerifyApiState = await userRepo.setIdentity(realname, id);
    if (idVerifyApiState.isSuccess) {
      await userRepo.getBasicInfo();
    }
    setLoading(false);
    return idVerifyApiState;
  }
}
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';


class RealNameVerificationViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();
  var idVerifyApiState, getBasicInfoApiState;

  @override
  List<BaseRepository> get repoList => [userRepo];
  get userProfile => userRepo.userProfile;

  /*idVerify(String name, String idNumber) async{
    setLoading();
    idVerifyApiState = await userRepo.idVerify(name, idNumber);
    setLoading(false);
    return idVerifyApiState;
  }

  getBasicInfo() async{
    setLoading();
    getBasicInfoApiState = await userRepo.getBasicInfo();
    setLoading(false);
    return getBasicInfoApiState;
  }

  resetApiState({bool isIdVerifyApiState = false, bool isGetBasicInfoApiState = false}){
    if(isIdVerifyApiState){
      idVerifyApiState = null;
    }
    else if(isGetBasicInfoApiState){
      getBasicInfoApiState = null;
    }
  }*/
}
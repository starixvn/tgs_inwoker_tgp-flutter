import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/event_type.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class EditPasswordViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();
  var editPasswordApiState;

  @override
  List<BaseRepository> get repoList => [userRepo];
  get userProfile => userRepo.userProfile;

  /*editPassword(String oldPassword, String newPassword, {String phone = "", String verCode = ""}) async{
    setLoading();
    editPasswordApiState = await userRepo.editPassword(oldPassword, newPassword);
    setLoading(false);
    return editPasswordApiState;
  }

  resetApiState({
    bool isEditPasswordApiState = false,
  }){
    if(isEditPasswordApiState){
      editPasswordApiState = null;
    }
  }*/
}
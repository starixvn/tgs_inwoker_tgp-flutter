import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:api_package/entity/event_type.dart';
 import 'package:api_package/api_package.dart';

class EditPasswordViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();
  var editPasswordApiState;

  @override
  List<BaseRepository> get repoList => [userRepo];
  get userProfile => userRepo.userProfile;

  editPassword(String oldPassword, String newPassword) async{
    setLoading();
    editPasswordApiState = await userRepo.editPassword(oldPassword, newPassword);
    setLoading(false);
    return editPasswordApiState;
  }
}
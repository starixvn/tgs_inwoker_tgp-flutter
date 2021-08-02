import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:shared_api/entity/event_type.dart';
import 'package:shared_api/repository/base_repository.dart';
import 'package:shared_api/repository/user_repository.dart';

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
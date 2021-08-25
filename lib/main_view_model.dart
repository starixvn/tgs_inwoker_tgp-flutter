import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/language_option.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class MainViewModel extends BaseViewModel{
  final contentRepo = ContentRepository.getSingleton();
  final userRepo = UserRepository.getSingleton();
  var authApiState, getLanguageApiState;

  @override
  List<BaseRepository> get repoList => [];

  getAuthToken()async{
    setLoading();
    authApiState = await userRepo.auth();
    setLoading(false);
    return authApiState;
  }

   getLanguageOption() async{
    setLoading();
    getLanguageApiState = await contentRepo.getLanguageOption();
    if (getLanguageApiState.isSuccess) {
    }
    setLoading(false);
    return getLanguageApiState;
  }
}
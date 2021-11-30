import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/language_option.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';
import 'package:tgp_flutter/testing/first_testing.mocks.dart';

class MainViewModel extends BaseViewModel{
  final contentRepo = ContentRepository.getSingleton();
  final userRepo = UserRepository.getSingleton();
  var authApiState, getLanguageApiState, getBrandLogoApiState;

  @override
  List<BaseRepository> get repoList => [];

  get brandLogoUrl => contentRepo.brandLogo?.mobileUrl;

  getAuthToken() async {
    setLoading();
    authApiState = await userRepo.auth();
    setLoading(false);
    return authApiState;
  }

  getLanguageOption() async {
    setLoading();
    getLanguageApiState = await contentRepo.getLanguageOption();
    if (getLanguageApiState.isSuccess) {}
    setLoading(false);
    return getLanguageApiState;
  }

  getBrandLogo() async {
    setLoading();
    getBrandLogoApiState = await contentRepo.getBrandLogo();
    setLoading(false);
    return getBrandLogoApiState;
  }

  getApiError() async {
    await userRepo.getApiErrorLocalization();
  }
}
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/brand_communication.dart';
import 'package:tgp_flutter/entity/language_option.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class MaintenanceViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [userRepo];

  get userProfile => userRepo.userProfile;

  get brandLogoUrl => contentRepo.brandLogo?.mobileUrl;

  var getBrandCommunicationApiState, getLiveChatUrlApiState;
  List<BrandCommunication>? communicationList;
  String? liveChatUrl;

  getBrandCommunication() async {
    setLoading();
    getBrandCommunicationApiState = await userRepo.getBrandCommunication();
    if (getLiveChatUrlApiState.isSuccess && getLiveChatUrlApiState.result.setting != null) {
      var _list = getBrandCommunicationApiState.result;
      communicationList = _list;
    }
    setLoading(false);
    return getBrandCommunicationApiState;
  }

  getLiveChatUrl(String languageCode) async {
    setLoading();
    getLiveChatUrlApiState = await userRepo.getLiveChatUrl();
    if (getLiveChatUrlApiState.isSuccess) {
      List<String> pattern = ["{name}", "{email}", "{lang}"]; //ABV list
      List<String> replace = [
        userProfile?.username ?? " ",
        userProfile?.email ?? " ",
        languageCode
      ]; //corresponding list
      Map<String, String> map = Map.fromIterables(pattern, replace);
      liveChatUrl =
          map.entries.fold(getLiveChatUrlApiState.result.setting.url, (prev, e) => prev!.replaceAll(e.key, e.value));
    }
    setLoading(false);
    return getLiveChatUrlApiState;
  }
}
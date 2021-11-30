import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/wallet.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/repository/wallet_repository.dart';

class ProfileViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();
  final walletRepo = WalletRepository.getSingleton();

  var logoutApiState, getWalletBalanceApiState;
  double? gameBalance;
  double? totalBalance;

  @override
  List<BaseRepository> get repoList => [userRepo];

  get userProfile => userRepo.userProfile;

  get balance => userRepo.wallet?.main;

  get brandLogoUrl => contentRepo.brandLogo?.mobileUrl;

  logout() async {
    setLoading();
    logoutApiState = await userRepo.logout();
    setLoading(false);
    return logoutApiState;
  }

  computeTotalBalance() async {
    var gameList = contentRepo.gameProviderList!.where((element) => element.transferWallet == true);

    var task = <Future>[];
    gameList.forEach((game) {
      task.add(_getGameWalletBalance(game));
    });
    await Future.wait(task);
    totalBalance = (balance ?? 0.0) + (gameBalance ?? 0.0);
    notifyListeners();
  }

  _getGameWalletBalance(GameProvider game) async {
    var state = await walletRepo.getGameWallet(game.code);
    if (state.isSuccess) {
      gameBalance = (gameBalance ?? 0.0) + state.result!.balance!;
    }
    notifyListeners();
  }
}

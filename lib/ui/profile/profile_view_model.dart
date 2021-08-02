import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:shared_api/entity/game.dart';
import 'package:shared_api/entity/game_provider.dart';
import 'package:shared_api/entity/wallet.dart';
import 'package:shared_api/network/event_result.dart';
import 'package:shared_api/repository/base_repository.dart';
import 'package:shared_api/repository/content_repository.dart';
import 'package:shared_api/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_api/repository/wallet_repository.dart';

class ProfileViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();
  final walletRepo = WalletRepository.getSingleton();

  var logoutApiState, getWalletBalanceApiState;
  double gameBalance = 0.0, totalBalance;

  @override
  List<BaseRepository> get repoList => [userRepo];

  get userProfile => userRepo.userProfile;

  get balance => userRepo.wallet.main;

  logout() async {
    setLoading();
    logoutApiState = await userRepo.logout();
    setLoading(false);
    return logoutApiState;
  }

  computeTotalBalance() async {
    var gameList = contentRepo.gameProviderList.where((element) => element.transferWallet == true);

    var task = <Future>[];
    gameList.forEach((game) {
      task.add(_getGameWalletBalance(game));
    });
    await Future.wait(task);
    totalBalance = balance + gameBalance;
    notifyListeners();
  }

  _getGameWalletBalance(GameProvider game) async {
    var state = await walletRepo.getGameWallet(game.code);
    if (state.isSuccess) {
      gameBalance += state.result.balance;
    }
    notifyListeners();
  }
}

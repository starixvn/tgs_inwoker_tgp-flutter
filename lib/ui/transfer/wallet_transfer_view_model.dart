import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:shared_api/entity/game_provider.dart';
import 'package:shared_api/entity/game_wallet.dart';
import 'package:shared_api/entity/wallet.dart';
import 'package:shared_api/repository/base_repository.dart';
import 'package:shared_api/repository/content_repository.dart';
import 'package:shared_api/repository/user_repository.dart';
import 'package:shared_api/repository/wallet_repository.dart';

class WalletTransferViewModel extends BaseViewModel {
  final contentRepo = ContentRepository.getSingleton();
  final walletRepo = WalletRepository.getSingleton();
  final userRepo = UserRepository.getSingleton();

  List<Wallet> walletList = List.empty();

  WalletTransferViewModel() {
    walletList = contentRepo.gameProviderList
        .where((element) => element.transferWallet == true)
        .map((e) => Wallet(e.code, e.name))
        .toList()
          ..insert(0, Wallet("-1", "main_wallet", isMainWallet: true));
  }

  get userMainWalletBalance => walletList.singleWhere((element) => element.isMainWallet).balance;

  get gameWalletList => walletList.where((element) => !element.isMainWallet).toList();

  @override
  List<BaseRepository> get repoList => [contentRepo];
  var transferAllToMainWalletApiState, transferWalletApiState, getWalletApiState;
  bool isFetchingBalance;

  /*get walletList => walletRepo.walletList;



  transferAllToMainWallet() async{
    setLoading();
    notifyListeners();
    transferAllToMainWalletApiState = await walletRepo.transferAllToMainWallet();
    setLoading(false);
    notifyListeners();
    return transferAllToMainWalletApiState ;
  }



  getTransferableWalletList(){
    return walletList.where((e) => e.purseType != 1).toList();
  }

  getNoneMainWalletList(){
    return walletList.where((e) => e.purseType == 2).toList();
  }

  getSingleWalletList(){
    return walletList.where((e) => e.purseType == 1).toList();
  }

  getMainWallet(){
    return getTransferableWalletList().singleWhere((e) => e.id == 10000);
  }
*/
  transferWallet(String gpCode, int transferAmount, bool isFundOut) async {
    setLoading();
    transferWalletApiState = await walletRepo.fundTransfer(gpCode, transferAmount, isFundOut);
    if (transferWalletApiState.isSuccess) {
      getAllWallet();
    }
    setLoading(false);
  }

  _getGameWalletBalance(Wallet wallet) async {
    wallet.balance = null;
    if (wallet.isMainWallet) {
      await userRepo.getWalletBalance();
      wallet.balance = userRepo.wallet.main;
    } else {
      var state = await walletRepo.getGameWallet(wallet.gpCode);
      if (state.isSuccess) {
        wallet.balance = state.result.balance;
      }
    }
    notifyListeners();
  }

  getAllWallet() async {
    isFetchingBalance = true;
    notifyListeners();
    var task = <Future>[];
    walletList.forEach((wallet) {
      task.add(_getGameWalletBalance(wallet));
    });
    await Future.wait(task);
    isFetchingBalance = false;
    if (hasListeners) notifyListeners();
  }
}

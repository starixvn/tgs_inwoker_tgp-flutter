import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/repository/base_repository.dart';

class WalletTransferViewModel extends BaseViewModel {
  //final walletRepo = WalletRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [ ];
  /*get walletList => walletRepo.walletList;

  var transferAllToMainWalletApiState, transferWalletApiState, getWalletApiState;

  transferAllToMainWallet() async{
    setLoading();
    notifyListeners();
    transferAllToMainWalletApiState = await walletRepo.transferAllToMainWallet();
    setLoading(false);
    notifyListeners();
    return transferAllToMainWalletApiState ;
  }

  transferWallet(
      int from,
      int to,
      double transferAmount
      ) async{
    transferWalletApiState = await walletRepo.transferWallet(from, to, transferAmount);
    setLoading();
    notifyListeners();
    setLoading(false);
    return transferWalletApiState ;
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

  getAllWallet() async{
    setLoading();
    notifyListeners();
    getWalletApiState = await walletRepo.getAllWallet();
    setLoading(false);
    notifyListeners();
    return getWalletApiState ;
  }*/
}
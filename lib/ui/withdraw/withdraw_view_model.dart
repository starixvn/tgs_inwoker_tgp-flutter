import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class WithdrawViewModel extends BaseViewModel {
  /*final userRepo = UserRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();
  final walletRepo = WalletRepository.getSingleton();*/

  @override
  List<BaseRepository> get repoList => [];
  /*get mainAccountBalance => walletRepo.mainAccountWalletBalance;
  get bankCardList => userRepo.bankCardList;

  var getWithdrawalInfoApiState, withdrawalApiState;
  var withdrawalInfo;

  getWithdrawalInfo() async{
    setLoading();
    userRepo.getBankCardList();
    getWithdrawalInfoApiState = await userRepo.getWithdrawalInfo();
    if(getWithdrawalInfoApiState.isSuccess){
      withdrawalInfo = getWithdrawalInfoApiState.result;
      notifyListeners();
    }
    setLoading(false);
    return getWithdrawalInfoApiState ;
  }

  withdraw(int bankId, int amount) async{
    setLoading();
    withdrawalApiState = await userRepo.withdrawal(bankId, amount);
    if(withdrawalApiState.isSuccess){
      walletRepo.getAllWallet();
      notifyListeners();
    }
    setLoading(false);
    return withdrawalApiState ;
  }

  resetApiState({bool isWithdrawalApiState = false, bool isGetWithdrawalInfoApiState = false}){
    if(isWithdrawalApiState) {
      withdrawalApiState = null;
    }
    if(isGetWithdrawalInfoApiState){
      getWithdrawalInfoApiState = null;
    }
  }*/
}

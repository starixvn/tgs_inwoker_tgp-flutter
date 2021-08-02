import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:shared_api/entity/withdrawal_info.dart';
import 'package:shared_api/repository/bank_repository.dart';
import 'package:shared_api/repository/base_repository.dart';
import 'package:shared_api/repository/content_repository.dart';
import 'package:shared_api/repository/user_repository.dart';
import 'package:collection/collection.dart';

class WithdrawViewModel extends BaseViewModel {
  final bankRepo = BankRepository.getSingleton();
  final userRepo = UserRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [];
  var getBankCardListApiState, withdrawApiState;
  var bankCardList;

  get wallet => userRepo.wallet;

  get userProfile => userRepo.userProfile;

  getBankCardList() async {
    setLoading();
    getBankCardListApiState = await bankRepo.getBankCardList();
    if (getBankCardListApiState.isSuccess) {
      bankCardList = getBankCardListApiState.result;
    }
    setLoading(false);
    return getBankCardListApiState;
  }

  withdraw(int amount, String bankInfoId, String payPassword) async {
    setLoading();
    var status = await bankRepo.withdraw(amount, bankInfoId, payPassword);
    if (status.isSuccess) {
      withdrawApiState = await userRepo.getWalletBalance();
    } else
      withdrawApiState = status;
    setLoading(false);
    return withdrawApiState;
  }
}

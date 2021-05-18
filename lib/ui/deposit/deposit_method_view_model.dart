import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/payment.dart';
import 'package:tgp_flutter/repository/bank_repository.dart';
import 'package:tgp_flutter/repository/base_repository.dart';

class DepositMethodViewModel extends BaseViewModel {
  final depositRepo = BankRepository.getSingleton();
  final Map<String, List<Payment>> depositMethodList;

  DepositMethodViewModel(this.depositMethodList);

  @override
  List<BaseRepository> get repoList => [];
  var getManualDepositIdApiState, getDepositOrderApiState, getCryptoIdApiState;

  List<Payment> paymentList;
  var depositOrder;

  filterMethod(String method) async {
    paymentList = depositMethodList[method];
    notifyListeners();
  }

  getManualDepositId(String account, String amount, String paymentId) async {
    setLoading();
    getManualDepositIdApiState = await depositRepo.getManualDepositId(account, amount, paymentId);
    if (getManualDepositIdApiState.isSuccess) {
      getDepositOrder(getManualDepositIdApiState.result);
    }
    setLoading(false);
    return getManualDepositIdApiState;
  }

  getDepositOrder(String id) async {
    setLoading();
    getDepositOrderApiState = await depositRepo.getDepositOrder(id);
    if (getDepositOrderApiState.isSuccess) {
      depositOrder = getDepositOrderApiState.result;
    }
    setLoading(false);
    return getDepositOrderApiState;
  }

  getCryptoId(String amount, String paymentId) async {
    setLoading();
    getCryptoIdApiState = await depositRepo.getCryptoId(amount, paymentId);
//    if (getCryptoIdApiState.isSuccess) {
//      getDepositOrder(getCryptoIdApiState.result);
//    }
    setLoading(false);
    return getCryptoIdApiState;
  }
}

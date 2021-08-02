import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:shared_api/entity/payment.dart';
import 'package:shared_api/entity/promotion.dart';
import 'package:shared_api/repository/bank_repository.dart';
import 'package:shared_api/repository/base_repository.dart';
import 'package:shared_api/repository/content_repository.dart';

class DepositMethodViewModel extends BaseViewModel {
  final depositRepo = BankRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();
  final Map<String, List<Payment>> depositMethodList;

  DepositMethodViewModel(this.depositMethodList);

  @override
  List<BaseRepository> get repoList => [];
  var getManualDepositIdApiState,
      getDepositOrderApiState,
      getLeepayOrderApiState,
      primePayDepositOrderApiState,
      applePayDepositOrderApiState,
  getExchangeRateApiState;
  List<Payment> paymentList;
  var depositOrder, orderNo, exchangeRate;

  filterMethod(String method) async {
    paymentList = depositMethodList[method];
    notifyListeners();
  }

  getManualDepositId(String account, String amount, String paymentId, String promotionId) async {
    setLoading();
    getManualDepositIdApiState = await depositRepo.getManualDepositId(account, amount, paymentId, promotionId);
    if (getManualDepositIdApiState.isSuccess) {
      orderNo = getManualDepositIdApiState.result;
      getManualDepositOrder(orderNo);
    }
    setLoading(false);
    return getManualDepositIdApiState;
  }

  getManualDepositOrder(String id) async {
    setLoading();
    getDepositOrderApiState = await depositRepo.getManualDepositOrder(id);
    if (getDepositOrderApiState.isSuccess) {
      depositOrder = getDepositOrderApiState.result;
    }
    setLoading(false);
    return getDepositOrderApiState;
  }

  leePayDepositOrder(String amount, String paymentId, String promotionId) async {
    setLoading();
    getLeepayOrderApiState = await depositRepo.leePayDepositOrder(amount, paymentId, promotionId);
    setLoading(false);
    return getLeepayOrderApiState;
  }

  primePayDepositOrder(String amount, String paymentId, String promotionId) async {
    setLoading();
    primePayDepositOrderApiState = await depositRepo.primePayDepositOrder(amount, paymentId, promotionId);
    setLoading(false);
    return primePayDepositOrderApiState;
  }


  applePayDepositOrder(String amount, String paymentId, String promotionId, String transName) async {
    setLoading();
    applePayDepositOrderApiState = await depositRepo.applePayDepositOrder(amount, paymentId, promotionId, transName);
    setLoading(false);
    return applePayDepositOrderApiState;
  }

  getExchangeRate(String paymentId) async{
    setLoading();
    getExchangeRateApiState = await depositRepo.getExchangeRate(paymentId);
    if(getExchangeRateApiState.isSuccess){
      exchangeRate = getExchangeRateApiState.result.buyPrice;
    }
    setLoading(false);
    return getExchangeRateApiState;
  }
}

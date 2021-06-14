import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/payment.dart';
import 'package:tgp_flutter/entity/promotion.dart';
import 'package:tgp_flutter/repository/bank_repository.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';

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
      getPlayerPromotionListApiState,
      applePayDepositOrderApiState;
  List<Payment> paymentList;
  var depositOrder, orderNo;
  List<Promotion> promotionList;
  var rows = 20;

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

  getPlayerPromotionList(int page) async {
    setLoading();
    getPlayerPromotionListApiState = await contentRepo.getPlayerPromotionList(page, rows, false, false);
    if (getPlayerPromotionListApiState.isSuccess) {
      promotionList = getPlayerPromotionListApiState.result.items;
    }
    setLoading(false);
    return getPlayerPromotionListApiState;
  }

  applePayDepositOrder(String amount, String paymentId, String promotionId, String transName) async {
    setLoading();
    applePayDepositOrderApiState = await depositRepo.applePayDepositOrder(amount, paymentId, promotionId, transName);
    setLoading(false);
    return applePayDepositOrderApiState;
  }
}

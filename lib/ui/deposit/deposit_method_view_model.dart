import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/bank_type.dart';
import 'package:tgp_flutter/entity/payment.dart';
import 'package:tgp_flutter/entity/promotion.dart';
import 'package:tgp_flutter/repository/bank_repository.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';

class DepositMethodViewModel extends BaseViewModel {
  final depositRepo = BankRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();
  final Map<BankType, List<Payment>> depositMethodList;

  DepositMethodViewModel(this.depositMethodList);

  @override
  List<BaseRepository> get repoList => [];
  var getManualDepositIdApiState,
      getDepositOrderApiState,
      getLeepayOrderApiState,
      primePayDepositOrderApiState,
      applePayDepositOrderApiState,
      getUmPayDepositOrderApiState,
      getExchangeRateApiState,
      maticPayDepositOrderApiState;
  List<Payment> paymentList;
  var depositOrder, orderNo, exchangeRate;

  get brandLogoUrl => contentRepo.brandLogo?.mobileUrl;

  filterMethod(BankType bankType) async {
    paymentList = depositMethodList[bankType];
    notifyListeners();
  }

  getManualDepositId(BankType bankType, String account, String amount, String paymentId, String promotionId) async {
    setLoading();
    if(bankType == BankType.BANK) getManualDepositIdApiState = await depositRepo.getManualBankDepositId(account, amount, paymentId, promotionId);
    else getManualDepositIdApiState = await depositRepo.getManualThirdPartyDepositId(account, amount, paymentId, promotionId);
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

  umPayDepositOrder(String amount, String paymentId, String promotionId, bool isCrypto) async {
    setLoading();
    if (isCrypto)
      getUmPayDepositOrderApiState = await depositRepo.umPayCryptoDepositOrder(amount, paymentId, promotionId);
    else
      getUmPayDepositOrderApiState = await depositRepo.umPayBankDepositOrder(amount, paymentId, promotionId);
    setLoading(false);
    return getUmPayDepositOrderApiState;
  }

  getExchangeRate(String paymentId, bool isUmPay) async {
    setLoading();
    if (!isUmPay)
      getExchangeRateApiState = await depositRepo.getLeePayExchangeRate(paymentId);
    else
      getExchangeRateApiState = await depositRepo.getUmPayExchangeRate(paymentId);
    if (getExchangeRateApiState.isSuccess) {
      if (!isUmPay)
        exchangeRate = getExchangeRateApiState.result.buyPrice;
      else
        exchangeRate = getExchangeRateApiState.result.rate.toString();
    }
    setLoading(false);
    return getExchangeRateApiState;
  }

  maticPayDepositOrder(String amount, String paymentId, String promotionId) async {
    setLoading();
    maticPayDepositOrderApiState = await depositRepo.maticPayDepositOrder(amount, paymentId, promotionId);
    setLoading(false);
    return maticPayDepositOrderApiState;
  }
}

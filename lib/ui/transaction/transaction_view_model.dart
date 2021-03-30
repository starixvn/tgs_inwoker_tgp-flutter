import 'package:flutter/cupertino.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/repository/base_repository.dart';

class TransactionViewModel extends BaseViewModel {
  /*final userRepo = UserRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();*/

  @override
  List<BaseRepository> get repoList => [/*userRepo, contentRepo*/];

 /* List<AccountTransaction> accountTransactionList;
  List<BetTransaction> betTransactionList;
  List<DailyTransaction> dailyTransactionList;

  var accountTransactionApiState, betTransactionApiState, dailyTransactionApiState;
  var pStartDate = DateTime.now();
  var pEndDate = DateTime.now();
  var pActionType = TransactionActionType.ALL;
  var pStatus = TransactionStatusType.ALL;
  var pThirdPartyId = 0;
  var pThirdPartyParentId = 0;
  var pTransactionThirdPartyType = TransactionThirdPartyType.ALL;
  var pTransactionBetStatusType = TransactionBetStatusType.SETTLED;
  var thirdPartyList, pThirdPartyList, thirdPartyIdList;
  var page = 1, limit =20;
  var accountTransactionResponse, betTransactionResponse, dailyTransactionResponse;
  var endRecord = false;

  getMoneyTransaction({
    DateTime startDate,
    DateTime endDate,
    TransactionActionType actionType,
    TransactionStatusType status,
    bool isLoadMore = false
  }) async {
    setLoading();
    notifyListeners();

    if(isLoadMore){
      if(page*limit < accountTransactionResponse.total){
        page++;
      }else return;
    }else{
      page =1;
      accountTransactionResponse = null;
      accountTransactionList = null;
    }

    if (startDate != null) pStartDate = startDate;
    if (endDate != null) pEndDate = endDate;
    if (actionType != null) pActionType = actionType;
    if (status != null) pStatus = status;
    var accountTransactionApiState = await userRepo.getMoneyTransaction(
        Format().dateFormat(pStartDate),
        Format().dateFormat(pEndDate),
        page,
        limit,
        pActionType,
        pStatus
    );

    var list = List<AccountTransaction>();
    if (accountTransactionApiState.isSuccess) {
      accountTransactionResponse = accountTransactionApiState.result;
      list = accountTransactionResponse.transactions;
      if(accountTransactionList == null){
        accountTransactionList = List<AccountTransaction>();
      }
      accountTransactionList.addAll(list);
      endRecord = accountTransactionList.length >=accountTransactionResponse.total?true:false;
      notifyListeners();
    }
    setLoading(false);
    notifyListeners();
    return accountTransactionApiState;
  }

  getBetTransaction({
    DateTime startDate,
    DateTime endDate,
    int thirdPartyId,
    int thirdPartyParentId,
    TransactionThirdPartyType transactionThirdPartyType,
    TransactionBetStatusType transactionBetStatusType,
    bool isLoadMore = false
  }) async {
    setLoading();
    notifyListeners();

    if(isLoadMore){
      if(page*limit < betTransactionResponse.total){
        page++;
      }else return;
    }else{
      page =1;
      betTransactionResponse = null;
      betTransactionList = null;
    }

    if (startDate != null) pStartDate = startDate;
    if (endDate != null) pEndDate = endDate;
    if (thirdPartyId != null) {
      if(pTransactionThirdPartyType == TransactionThirdPartyType.ALL){
        pThirdPartyParentId = thirdPartyId;
        pThirdPartyId = 0;
      }
      else{
        pThirdPartyParentId = 0;
        pThirdPartyId = thirdPartyId;
      }
    }
    if(transactionThirdPartyType != null) pTransactionThirdPartyType = transactionThirdPartyType;
    if(transactionBetStatusType != null) pTransactionBetStatusType = transactionBetStatusType;
    var betTransactionApiState = await userRepo.getBetTransaction(
        Format().dateFormat(pStartDate),
        Format().dateFormat(pEndDate),
        page,
        limit,
        pThirdPartyId,
        pThirdPartyParentId,
        pTransactionThirdPartyType,
        pTransactionBetStatusType
    );

    var list = List<BetTransaction>();
    if (betTransactionApiState.isSuccess) {
      betTransactionResponse = betTransactionApiState.result;
      list = betTransactionResponse.transactions;
      if(betTransactionList == null){
        betTransactionList = List<BetTransaction>();
      }
      betTransactionList.addAll(list);
      endRecord = betTransactionList.length >=betTransactionResponse.total?true:false;
      notifyListeners();
    }
    setLoading(false);
    notifyListeners();
    return betTransactionApiState;
  }

  getDailyTransaction({
    DateTime startDate,
    DateTime endDate,
    int thirdPartyId,
    int thirdPartyParentId,
    TransactionThirdPartyType transactionThirdPartyType,
  }) async {
    setLoading();
    notifyListeners();

    if (startDate != null) pStartDate = startDate;
    if (endDate != null) pEndDate = endDate;
    if (thirdPartyId != null) {
      if(pTransactionThirdPartyType == TransactionThirdPartyType.ALL){
        pThirdPartyParentId = thirdPartyId;
        pThirdPartyId = 0;
      }
      else{
        pThirdPartyParentId = 0;
        pThirdPartyId = thirdPartyId;
      }
    }
    if(transactionThirdPartyType != null) pTransactionThirdPartyType = transactionThirdPartyType;

    var dailyTransactionApiState = await userRepo.getDailyTransaction(
        Format().dateFormat(pStartDate),
        Format().dateFormat(pEndDate),
        pThirdPartyId,
        pThirdPartyParentId,
        pTransactionThirdPartyType
    );

    if (dailyTransactionApiState.isSuccess) {
      dailyTransactionResponse = dailyTransactionApiState.result;
      dailyTransactionList = dailyTransactionResponse.transactions;
      endRecord = dailyTransactionList.length >=dailyTransactionResponse.total?true:false;
      notifyListeners();
    }
    setLoading(false);
    notifyListeners();
    return dailyTransactionApiState;
  }

  filter(DateTime startDate) {
    pStartDate = startDate;
    pEndDate = DateTime.now();
  }

  getThirdPartyList() async{
    var result = await contentRepo.getThirdPartyList();
    if(result.isSuccess){
      pThirdPartyList = result.result;
      filterThirdParty(type: pTransactionThirdPartyType);
    }
    notifyListeners();
  }

  filterThirdParty({TransactionThirdPartyType type}){
    if(type  == null){
      type = pTransactionThirdPartyType;
    }
    if(type == TransactionThirdPartyType.ALL){
      thirdPartyList = pThirdPartyList.where((e) => e.parentId == 0 && e. purseType !=0).toList();

    }
    else{
      thirdPartyList = pThirdPartyList.where((e) => e.type == type).toList();
    }
    _getThirdPartyList();
    notifyListeners();
  }

  resetApiState({
    bool isAccountTransaction = false,
    bool isBetTransaction = false,
    bool isDailyTransaction = false,
  }){
    if(isAccountTransaction) accountTransactionApiState = null;
    if(isBetTransaction) betTransactionApiState = null;
    if(isDailyTransaction) dailyTransactionApiState = null;
  }

  _getThirdPartyList(){
    thirdPartyIdList = List<TransactionThirdParty>();
    thirdPartyList = thirdPartyList;
    for (int i = 0; i< thirdPartyList.length; i++){
      thirdPartyIdList.add(
          TransactionThirdParty(
              thirdPartyList[i].id,
              thirdPartyList[i].name
          )
      );
    }
    thirdPartyIdList.insert(0,
        TransactionThirdParty(
            0,
            "全部"
        ));
    return thirdPartyIdList;
  }*/

}
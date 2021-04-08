import 'package:flutter/cupertino.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/bet_transaction.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class TransactionViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();
  var getTransactionApiState, getGameProviderApiState;
  var page = 1, rows =20;
  var pStartDate = DateTime.now();
  var pEndDate = DateTime.now();
  List<BetTransaction> betTransactionList;
  var endRecord = false;

  get gameProviderList => contentRepo.gameProviderList;

  @override
  List<BaseRepository> get repoList => [userRepo, contentRepo];

  getTransaction({
    DateTime startDate,
    DateTime endDate,
    /*int orderBy,
      {bool isDesc,
        String sortBy,
        bool showAll = false}*/
    bool isLoadMore = false
  }) async{
    setLoading();

    if(isLoadMore){
      if(page*rows < getTransactionApiState.result.totalCount){
        page++;
      }else return;
    }else{
      page =1;
      getTransactionApiState = null;
      betTransactionList = null;
    }
    if (startDate != null) pStartDate = startDate;
    if (endDate != null) pEndDate = endDate;

    print("======");
    print(pStartDate);
    print(pEndDate);
    getTransactionApiState = await userRepo.getTransaction(pStartDate, pEndDate, page, rows/*, orderBy, isDesc, sortBy, showAll*/);

    List<BetTransaction> list=[];
    if(getTransactionApiState.isSuccess){
      list = getTransactionApiState.result.items;
      if(betTransactionList == null) betTransactionList = [];
      betTransactionList.addAll(list);
      endRecord = betTransactionList.length >= getTransactionApiState.result.totalCount?true:false;
    }
    setLoading(false);
    return getTransactionApiState;
  }

  filter(DateTime startDate){
    pStartDate = startDate;
    pEndDate = DateTime.now();
  }

  getGameProviderList() async{
    setLoading();
    getGameProviderApiState = await contentRepo.getGameProviderList();
    setLoading(false);
    return getGameProviderApiState;

  }
}
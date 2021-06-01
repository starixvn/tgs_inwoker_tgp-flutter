import 'package:flutter/cupertino.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/bet_transaction.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class TransactionViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();
  var getTransactionApiState, getGameProviderApiState;
  var page = 1, rows = 10;
  var pStartDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0, 0, 0),
      pEndDate = DateTime.now();
  List<BetTransaction> betTransactionList;
  var endRecord = false;
  var accountTransactionList;

  get gameProviderList => contentRepo.gameProviderList;

  get wallet => userRepo.wallet;

  @override
  List<BaseRepository> get repoList => [userRepo, contentRepo];

  getTransaction({bool isLoadMore = false}) async {
    setLoading();

    if (isLoadMore) {
      if (page * rows < getTransactionApiState.result.totalCount) {
        page++;
      } else
        return;
    } else {
      page = 1;
      getTransactionApiState = null;
      betTransactionList = null;
    }
    getTransactionApiState =
        await userRepo.getTransaction(pStartDate, pEndDate, page, rows /*, orderBy, isDesc, sortBy, showAll*/);

    List<BetTransaction> list = [];
    if (getTransactionApiState.isSuccess) {
      list = getTransactionApiState.result.items;
      if (betTransactionList == null) betTransactionList = [];

      betTransactionList.addAll(list);
      endRecord = betTransactionList.length >= getTransactionApiState.result.totalCount ? true : false;
    }
    setLoading(false);
    return getTransactionApiState;
  }

  setDate({DateTime startDate, endDate}) {
    if (startDate != null) pStartDate = startDate;
    if (endDate != null) pEndDate = endDate;
    notifyListeners();
  }

  getGameProviderList() async {
    setLoading();
    getGameProviderApiState = await contentRepo.getGameProviderList();
    setLoading(false);
    return getGameProviderApiState;
  }
}

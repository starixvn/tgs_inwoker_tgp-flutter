import 'package:collection/collection.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class DepositViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [];
  var getDepositActsApiState, depositApiState, depositStatusApiState;

  get wallet => userRepo.wallet;

/* getPayment() async{
    var value = await contentRepo.getPayment();
    paymentChannel =
        groupBy(value.result.payments, (obj) => obj.typeClass)
            .entries
            .map( (e) =>
            PaymentChannel(e.key, e.value.first.typeTitle, e.value)
        ).toList();
  }

  getDepositActs(int amount) async{
    getDepositActsApiState  = await contentRepo.getDepositActs(amount);
    setLoading();
    notifyListeners();
    isDepositHandled = true;
    if(getDepositActsApiState.isSuccess){
      depositActsList =
          groupBy(getDepositActsApiState.result, (obj) => obj.bonusId)
              .entries
              .map( (e) =>
              DepositBonusGroup(e.value.first, e.value)
          ).toList();
    }
    setLoading(false);
    return getDepositActsApiState;
  }

  markIsDepositHandled(){
    isDepositHandled = false;
  }

  deposit(int agentID, int amount, int bospID,String bankID) async{
    depositApiState = await userRepo.deposit(agentID, amount,null, null);
    setLoading();
    notifyListeners();
    if(depositApiState.isSuccess){
      depositResponse = depositApiState.result;
    }
    setLoading(false);
    return depositApiState ;
  }

  resetApiState(bool isDepositApiState, bool isGetDepositActsApiState, bool isDepositStatusApiState){
    if(isDepositApiState) depositApiState = null;
    if(isGetDepositActsApiState) getDepositActsApiState = null;
    if(isDepositStatusApiState) depositStatusApiState = null;
  }

  depositStatus(int id, bool isCancel)async{
    setLoading();
    if(isCancel) depositStatusApiState = await userRepo.cancelDeposit(id);
    else depositStatusApiState = await userRepo.checkDeposit(id);

    setLoading(false);
    notifyListeners();
    return depositStatusApiState ;
  }*/
}

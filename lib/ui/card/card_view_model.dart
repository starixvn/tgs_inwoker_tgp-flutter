import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';


class CardViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();
  //final walletRepo = WalletRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [userRepo, contentRepo,];
  /*get mainAccountBalance => walletRepo.mainAccountWalletBalance;
  get userProfile => userRepo.userProfile;

  var addCardApiState, deleteCardApiState, editSurnameApiState,
      updateWithdrawPasswordApiState, getBankCardApiState;

  getBankCardList() async{
    setLoading();
    getBankCardApiState = await userRepo.getBankCardList();
    setLoading(false);
  return getBankCardApiState;
  }

  addCard(String bankAccount, String safePassword) async{
    setLoading();
    addCardApiState  = await userRepo.addCard(bankAccount, safePassword);
    if(addCardApiState.isSuccess){
      getBankCardList();
    }
    setLoading(false);
    return addCardApiState;
  }

  deleteCard(int bankAccountId) async{
    setLoading();
    deleteCardApiState  = await userRepo.deleteCard(bankAccountId);
    setLoading(false);
    return deleteCardApiState;
  }

  editSurname(String name) async{
    setLoading();
    editSurnameApiState  = await userRepo.editSurname(name);
    if(editSurnameApiState.isSuccess){
      userRepo.getBasicInfo();
    }
    setLoading(false);
    return editSurnameApiState;
  }

  updateWithdrawPassword(String password, {String oldPassword = ""}) async{
    setLoading();
    updateWithdrawPasswordApiState  = await userRepo.updateWithdrawPassword(oldPassword, password);
    if(updateWithdrawPasswordApiState.isSuccess){
      userRepo.getBasicInfo();
    }
    setLoading(false);
    return updateWithdrawPasswordApiState;
  }

  resetApiState({
   //bool isGetBankCardApiState= false,
    bool isAddCardApiState = false,
    bool isEditSurnameApiState = false,
    bool isUpdateWithdrawPasswordApiState = false,
    bool isDeleteCardApiState = false,
  }){
    if(isAddCardApiState) {
      addCardApiState = null;
    }
    else if(isEditSurnameApiState){
      editSurnameApiState = null;
    }
    else if(isUpdateWithdrawPasswordApiState){
      updateWithdrawPasswordApiState = null;
    }
    else if(isDeleteCardApiState){
      deleteCardApiState = null;
    }
  }*/
}

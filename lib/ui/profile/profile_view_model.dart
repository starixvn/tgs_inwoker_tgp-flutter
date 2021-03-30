
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileViewModel extends BaseViewModel{
  final userRepo = UserRepository.getSingleton();

  var logoutApiState, getAllWalletState;

  //get totalBalance => _computeTotalBalance();

  @override
  List<BaseRepository> get repoList => [userRepo, ];
  get userProfile => userRepo.userProfile;

  logout() async{
    setLoading();;
    logoutApiState  = await UserRepository.getSingleton().logout();
    if(logoutApiState.isSuccess){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("token");
    }
    setLoading();
    return logoutApiState;
  }
  /*getTotalBalance(){
    WalletRepository.getSingleton().getAllWallet();
  }

  _computeTotalBalance(){
    var total;
    walletRepo.walletList?.forEach((element) {
      if(total == null) total = 0.0;
      total += double.tryParse(element.balance.toString()) ?? 0.0;
    });
    return total;
  }*/
}
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class AddressViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();
  var updateAddressApiState, getBasicInfoApiState;

  @override
  List<BaseRepository> get repoList => [userRepo];

  get userProfile => userRepo.userProfile;

/*updateAddress(String receiverName, String receiverAddress, String receiverContact, String zipCode) async{
    setLoading();
    updateAddressApiState = await userRepo.updateAddress(receiverName, receiverAddress, receiverContact);
    setLoading(false);
    return updateAddressApiState;
  }

  getBasicInfo() async{
    setLoading();
    getBasicInfoApiState = await userRepo.getBasicInfo();
    setLoading(false);
    return getBasicInfoApiState;
  }

  resetApiState({
    bool isUpdateAddressApiState = false,
    bool isGetBasicInfoApiState = false,
  }){
    if(isUpdateAddressApiState){
      updateAddressApiState = null;
    }else if(isGetBasicInfoApiState){
      getBasicInfoApiState = null;
    }
  }*/
}

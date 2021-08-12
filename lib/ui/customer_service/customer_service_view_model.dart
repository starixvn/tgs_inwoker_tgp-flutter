import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:api/entity/bank_type.dart';
import 'package:api/entity/brand_communication.dart';
import 'package:api/entity/withdrawal_info.dart';
import 'package:api/network/event_result.dart';
import 'package:api/api.dart';
import 'package:collection/collection.dart';

class CustomerServiceViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [userRepo];

  var getBrandCommunicationApiState;
  List<BrandCommunication> communicationList;

  getBrandCommunication() async {
    setLoading();
    getBrandCommunicationApiState = await userRepo.getBrandCommunication();
    if (getBrandCommunicationApiState.isSuccess) {
      communicationList = getBrandCommunicationApiState.result;
    }
    setLoading(false);
    return getBrandCommunicationApiState;
  }
}

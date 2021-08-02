import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:shared_api/entity/bank_type.dart';
import 'package:shared_api/entity/brand_communication.dart';
import 'package:shared_api/entity/withdrawal_info.dart';
import 'package:shared_api/network/event_result.dart';
import 'package:shared_api/repository/bank_repository.dart';
import 'package:shared_api/repository/base_repository.dart';
import 'package:shared_api/repository/content_repository.dart';
import 'package:shared_api/repository/user_repository.dart';
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

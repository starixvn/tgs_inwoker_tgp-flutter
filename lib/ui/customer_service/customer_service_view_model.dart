import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/bank_type.dart';
import 'package:tgp_flutter/entity/brand_communication.dart';
import 'package:tgp_flutter/entity/withdrawal_info.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/bank_repository.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';
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

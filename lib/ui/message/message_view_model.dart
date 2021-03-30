import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/promotion.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';

class MessageViewModel extends BaseViewModel {
  /*final messageRepo = MessageRepository.getSingleton();
  EventResult getMessageListState;
  List<Promotion> promotionList;*/

  @override
  List<BaseRepository> get repoList => [/*messageRepo*/];


}
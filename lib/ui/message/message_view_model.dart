import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/message.dart';
import 'package:tgp_flutter/entity/promotion.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/message_repository.dart';

class MessageViewModel extends BaseViewModel {
  final messageRepo = MessageRepository.getSingleton();
  EventResult getMessageListApiState;
  List<Message> messageList;
  var page = 1, rows=10;

  @override
  List<BaseRepository> get repoList => [messageRepo];

  getMessageList() async {
    setLoading();
    getMessageListApiState = await messageRepo.getMessageList(page, rows);
    if(getMessageListApiState.isSuccess){
      messageList = getMessageListApiState.result.items;
    }
    setLoading(false);
    return getMessageListApiState;
  }
}
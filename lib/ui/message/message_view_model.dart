import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:api_package/entity/message.dart';
import 'package:api_package/entity/promotion.dart';
import 'package:api_package/network/event_result.dart';
 import 'package:api_package/api_package.dart';

class MessageViewModel extends BaseViewModel {
  final messageRepo = MessageRepository.getSingleton();
  EventResult getMessageListApiState, readMessageApiState;
  List<Message> messageList;
  var page = 1, rows = 10;

  bool endRecord;

  @override
  List<BaseRepository> get repoList => [messageRepo];

  getMessageList({isLoadMore = false}) async {
    setLoading();

    if (isLoadMore) {
      if (page * rows < getMessageListApiState.result.totalCount)
        page++;
      else
        return;
    } else
      page = 1;

    getMessageListApiState = await messageRepo.getMessageList(page, rows);
    List<Message> list = [];
    if (getMessageListApiState.isSuccess) {
      list = getMessageListApiState.result.items;
      if (messageList == null) messageList = [];
      if(page == 1) messageList = [];
      messageList.addAll(list);
      endRecord = messageList.length >= getMessageListApiState.result.totalCount ? true : false;
    }
    setLoading(false);
    return getMessageListApiState;
  }

  readMessage(List<String> idList) async {
    setLoading();
    var state = await messageRepo.readMessage(idList);
    if (state.isSuccess) {
      readMessageApiState = await getMessageList();
    }
    setLoading(false);
    return readMessageApiState;
  }
}

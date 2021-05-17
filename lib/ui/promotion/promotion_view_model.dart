import 'package:tgp_flutter/entity/promotion.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/base_viewmodel.dart';

class PromotionViewModel extends BaseViewModel {
  final contentRepo = ContentRepository.getSingleton();
  EventResult getPromotionState;

  @override
  List<BaseRepository> get repoList => [contentRepo];
  var getPromotionListApiState, joinPromotionApiState;
  var promotionList;
  int page, rows = 10;
  bool endRecord;

  getPromotionList({isLoadMore = false}) async {
    setLoading();

    if (isLoadMore) {
      if (page * rows < getPromotionListApiState.result.totalCount)
        page++;
      else
        return;
    } else
      page = 1;

    getPromotionListApiState = await contentRepo.getPromotionList(page, rows, true, true);
    List<Promotion> list = [];
    if (getPromotionListApiState.isSuccess) {
      list = getPromotionListApiState.result.items;
      if (promotionList == null) promotionList = [];
      promotionList.addAll(list);
      endRecord = promotionList.length >= getPromotionListApiState.result.totalCount ? true : false;
    }
    setLoading(false);
    return getPromotionListApiState;
  }

  joinPromotion(String id) async {
    setLoading();
    joinPromotionApiState = await contentRepo.joinPromotion(id);
    if (joinPromotionApiState.isSuccess) {

    }
    setLoading(false);
    return joinPromotionApiState;
  }
}

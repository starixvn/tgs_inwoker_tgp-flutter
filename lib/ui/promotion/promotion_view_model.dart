import 'package:tgp_flutter/entity/promotion.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class PromotionViewModel extends BaseViewModel {
  final contentRepo = ContentRepository.getSingleton();
  final userRepo = UserRepository.getSingleton();
  EventResult getPromotionState;

  @override
  List<BaseRepository> get repoList => [userRepo, contentRepo];

  get userProfile => userRepo.userProfile;
  get brandLogoUrl => contentRepo.brandLogo?.mobileUrl;
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

    //if (userProfile == null)
      getPromotionListApiState = await contentRepo.getPromotionList(page, rows, true, true, userProfile == null);
   /* else
      getPromotionListApiState = await contentRepo.getPlayerPromotionList(page, rows, true, true);*/
    List<Promotion> list = [];
    if (getPromotionListApiState.isSuccess) {
      list = getPromotionListApiState.result.items;
      if (promotionList == null) promotionList = [];
      if(list.isNotEmpty) promotionList.addAll(list);
      endRecord = promotionList.length >= getPromotionListApiState.result.totalCount ? true : false;
    } else
      promotionList = [];
    setLoading(false);
    return getPromotionListApiState;
  }

  joinPromotion(String id) async {
    setLoading();
    joinPromotionApiState = await contentRepo.joinPromotion(id);
    setLoading(false);
    return joinPromotionApiState;
  }
}

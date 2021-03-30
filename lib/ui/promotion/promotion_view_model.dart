
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/base_viewmodel.dart';

class PromotionViewModel extends BaseViewModel {
  final contentRepo = ContentRepository.getSingleton();
  EventResult getPromotionState;

  @override
  List<BaseRepository> get repoList => [contentRepo];

  getPromotionList()async{
    /*getPromotionState = EventResult.loading();
    var value  = await contentRepo.getPromotion();
    getPromotionState = value;
    if(value.isSuccess){
      promotionList = value.result;
    }
    notifyListeners();
    return value;*/
  }
}
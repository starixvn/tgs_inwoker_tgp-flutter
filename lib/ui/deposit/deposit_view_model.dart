import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:shared_api/entity/payment.dart';
import 'package:shared_api/entity/promotion.dart';
import 'package:shared_api/network/event_result.dart';
import 'package:shared_api/repository/base_repository.dart';
import 'package:shared_api/repository/content_repository.dart';
import 'package:shared_api/repository/bank_repository.dart';
import 'package:shared_api/repository/user_repository.dart';

class DepositViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();
  final depositRepo = BankRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [];
  var getPaymentApiState, uploadDepositImageApiState, getPlayerPromotionListApiState;
  Map<String, Map<String, List<Payment>>> paymentCodeList;
  List<Payment> paymentList;
  var manualDepositOrder;
  List<Promotion> promotionList;
  List<Map<String, String>> displayPromotionList = [
    {"name": "promotion_picker_hint", "payment_id": "-1"}
  ];
  var rows = 20;

  get wallet => userRepo.wallet;

  getPayment() async {
    setLoading();
    getPaymentApiState = await depositRepo.getPayment();
    if (getPaymentApiState.isSuccess) {
      List<Payment> list = getPaymentApiState.result;
      paymentCodeList = groupBy(list, (obj) => obj.paymentCode)
          .map((key, value) => MapEntry(key, groupBy(value, (obj) => obj.methodCode)));
    }
    setLoading(false);
    return getPaymentApiState;
  }

  uploadDepositImage(String imageFile, String id) async {
    setLoading();
    uploadDepositImageApiState = await depositRepo.uploadDepositImage(imageFile, id);
    if (uploadDepositImageApiState.isSuccess) {}
    setLoading(false);
    return uploadDepositImageApiState;
  }

  getPlayerPromotionList(int page) async {
    setLoading();
    getPlayerPromotionListApiState = await contentRepo.getPlayerPromotionList(page, rows, false, false);
    if (getPlayerPromotionListApiState.isSuccess) {
      var list = getPlayerPromotionListApiState.result.items;
      list.asMap().forEach((index, value) {
        if (value.localization == null || value.localization.name.isEmpty)
          displayPromotionList.add({"name": value.name, "payment_id": value.id});
        else
          displayPromotionList.add({"name": value.localization.name, "payment_id": value.id});
      });
    }
    setLoading(false);
    return getPlayerPromotionListApiState;
  }
}

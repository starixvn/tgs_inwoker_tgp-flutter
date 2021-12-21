import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/bank_type.dart';
import 'package:tgp_flutter/entity/payment.dart';
import 'package:tgp_flutter/entity/promotion.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/bank_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class DepositViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();
  final depositRepo = BankRepository.getSingleton();
  final contentRepo = ContentRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [];
  var getPaymentApiState, uploadDepositImageApiState, getPlayerPromotionListApiState;
  Map<String, Map<BankType, List<Payment>>>? paymentCodeList;
  List<Payment>? paymentList;
  var manualDepositOrder;
  List<Map<String, String>> displayPromotionList = [
    {"name": "promotion_picker_hint", "id": "-1"}
  ];
  var rows = 20;

  get wallet => userRepo.wallet;

  get userProfile => userRepo.userProfile;

  get brandLogoUrl => contentRepo.brandLogo?.mobileUrl;

  getPayment() async {
    setLoading();
    getPaymentApiState = await depositRepo.getPayment();
    if (getPaymentApiState.isSuccess) {
      List<Payment> list = getPaymentApiState.result;
      list.sort((a, b) => (a.order ?? 0).compareTo(b.order ?? 0));
      paymentCodeList = groupBy(list, (Payment obj) => obj.paymentCode)
          .map((key, value) => MapEntry(key!, groupBy(value, (obj) => obj.bankType!)));
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
    getPlayerPromotionListApiState = await contentRepo.getPromotionList(page, rows, true, true, userProfile == null);
    if (getPlayerPromotionListApiState.isSuccess) {
      List<Promotion> list = getPlayerPromotionListApiState.result.items;
      list.forEach((value) {
        displayPromotionList.add({"name": (value.localization?.name ?? value.name) ?? "", "id": value.id ?? ""});
      });
    }
    setLoading(false);
    return getPlayerPromotionListApiState;
  }
}

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/payment.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/deposit_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class DepositViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();
  final depositRepo = DepositRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [];
  var getPaymentApiState, getManualDepositIdApiState, getDepositOrderApiState, uploadDepositImageApiState;
  Map<String, List<Payment>> depositMethodList = new Map<String, List<Payment>>();
  Map<String, List<Payment>> paymentCodeList = new Map<String, List<Payment>>();
  List<Payment> paymentList;
  String pMethod = "Crypto";
  var depositOrder;

  get wallet => userRepo.wallet;

  getPayment() async {
    setLoading();
    getPaymentApiState = await depositRepo.getPayment();
    if(getPaymentApiState.isSuccess){
      List<Payment> list = getPaymentApiState.result;
      paymentCodeList = groupBy(list, (obj) => obj.paymentCode);
      depositMethodList = groupBy(paymentCodeList.values.expand((element) => element), (obj) => obj.methodCode);
    }
    setLoading(false);
    return getPaymentApiState;
  }

  filterMethod({String method}) async{
    await getPayment();
    if(method !=null) pMethod = method;
    paymentList = depositMethodList[pMethod];
    notifyListeners();
  }

  getManualDepositId(String account,String amount, String paymentId) async{
    setLoading();
    getManualDepositIdApiState = await depositRepo.getManualDepositId(account, amount, paymentId);
    if(getManualDepositIdApiState.isSuccess){
      getDepositOrder(getManualDepositIdApiState.result);
    }
    setLoading(false);
    return getManualDepositIdApiState;
  }

  getDepositOrder(String id) async{
    setLoading();
    getDepositOrderApiState = await depositRepo.getDepositOrder(id);
    if(getDepositOrderApiState.isSuccess){
      depositOrder = getDepositOrderApiState.result;
    }
    setLoading(false);
    return getDepositOrderApiState;
  }

  uploadDepositImage (String imageFile, String id) async{
    setLoading();
    uploadDepositImageApiState = await depositRepo.uploadDepositImage(imageFile, id);
    if(uploadDepositImageApiState.isSuccess){
    }
    setLoading(false);
    return uploadDepositImageApiState;
  }
}
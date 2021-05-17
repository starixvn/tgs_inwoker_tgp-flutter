
import 'dart:convert';
import 'dart:io';

import 'package:tgp_flutter/entity/bank_card.dart';
import 'package:tgp_flutter/entity/bank_type.dart';
import 'package:tgp_flutter/entity/deposit_order.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/http_method.dart';
import 'package:tgp_flutter/entity/payment.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/entity/withdrawal_info.dart';
import 'package:tgp_flutter/network/api_request_builder.dart';
import 'package:tgp_flutter/network/event_result.dart';

import 'base_repository.dart';

class BankRepository extends BaseRepository {
  static BankRepository _singleton;
  UserProfile userProfile;
  List<GameProvider> gameProviderList;

  static BankRepository getSingleton() {
    if (_singleton == null) {
      _singleton = BankRepository();
    }
    return _singleton;
  }

  Future<EventResult<List<Payment>>> getPayment() async {
    return await ApiRequestBuilder<List<Payment>>(
        method: HttpMethod.GET,
        endPoint: "api/Deposit",
        converter:  (json){
          return (json as List<dynamic>).map((e) =>
              Payment.fromJson(e)
          ).toList();
        },
        jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> getManualDepositId(String account, String amount, String paymentId) async {
    return await ApiRequestBuilder<dynamic>(
        method: HttpMethod.PUT,
        endPoint: "api/deposit/manual",
        params: {
          "account": account,
          "amount": amount,
          "paymentid": paymentId,
        },
        jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<DepositOrder>> getDepositOrder (String id) async {
    return await ApiRequestBuilder<DepositOrder>(
        method: HttpMethod.GET,
        endPoint: "api/Deposit/manual",
        params: id,
        converter: (json) => DepositOrder.fromJson(json),
        jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> uploadDepositImage (String imageFile, String id) async {
    return await ApiRequestBuilder<dynamic>(
        method: HttpMethod.MULTIPART,
        endPoint: "api/Deposit/manual",
        params: id,
        imageContent:imageFile,
        jwtRefresher: jwtAuth)
            .execute();
  }

  Future<EventResult<List<WithdrawalInfo>>> getWithdrawalInfoList() async {
    return await ApiRequestBuilder<List<WithdrawalInfo>>(
        method: HttpMethod.GET,
        endPoint: "api/withdraw",
        converter: (json) => (json as List<dynamic>).map((e) => WithdrawalInfo.fromJson(e)).toList(),
        jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<List<BankCard>>> getBankCardList() async {
    return await ApiRequestBuilder<List<BankCard>>(
        method: HttpMethod.GET,
        endPoint: "api/bankinfo",
        converter: (json) => (json as List<dynamic>).map((e) => BankCard.fromJson(e)).toList(),
        jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> addBankCard(String paymentChannelId, BankType bankType, String address) async {
    return await ApiRequestBuilder<dynamic>(
        method: HttpMethod.POST,
        endPoint: "api/bankinfo",
        params: {
          "paymentchannelid": paymentChannelId,
          "banktype": bankType.displayName,
          "detail": {
            "address": address
          },
        },
        jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> deleteBankCard(String bankInfoId) async {
    return await ApiRequestBuilder<dynamic>(
        method: HttpMethod.DELETE,
        endPoint: "api/bankinfo/$bankInfoId",
        jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> getCryptoId(String amount, String paymentId) async {
    return await ApiRequestBuilder<dynamic>(
        method: HttpMethod.PUT,
        endPoint: "api/deposit/crypto",
        params: {
          "amount": amount,
          "paymentid": paymentId,
        },
        jwtRefresher: jwtAuth)
        .execute();
  }
}

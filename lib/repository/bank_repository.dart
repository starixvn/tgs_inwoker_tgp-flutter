import 'dart:convert';
import 'dart:io';

import 'package:tgp_flutter/entity/bank_card.dart';
import 'package:tgp_flutter/entity/bank_type.dart';
import 'package:tgp_flutter/entity/deposit_redirect.dart';
import 'package:tgp_flutter/entity/deposit_redirect_applepay.dart';
import 'package:tgp_flutter/entity/exchange_rate.dart';
import 'package:tgp_flutter/entity/manual_deposit_order.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/http_method.dart';
import 'package:tgp_flutter/entity/payment.dart';
import 'package:tgp_flutter/entity/umpay_exchange_rate.dart';
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
            converter: (json) {
              return (json as List<dynamic>).map((e) => Payment.fromJson(e)).toList();
            },
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<String>> getManualBankDepositId(
      String account, String amount, String paymentId, String promotionId) async {
    return await ApiRequestBuilder<String>(
            method: HttpMethod.PUT,
            endPoint: "api/deposit/manual/bank",
            params: {
              "account": account,
              "amount": amount,
              "paymentid": paymentId,
              "promotionid": promotionId,
            },
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<String>> getManualThirdPartyDepositId(
      String account, String amount, String paymentId, String promotionId) async {
    return await ApiRequestBuilder<String>(
        method: HttpMethod.PUT,
        endPoint: "api/deposit/manual/thirdparty",
        params: {
          "account": account,
          "amount": amount,
          "paymentid": paymentId,
          "promotionid": promotionId,
        },
        jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<ManualDepositOrder>> getManualDepositOrder(String id) async {
    return await ApiRequestBuilder<ManualDepositOrder>(
            method: HttpMethod.GET,
            endPoint: "api/Deposit/manual",
            params: id,
            converter: (json) => ManualDepositOrder.fromJson(json),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> uploadDepositImage(String imageFile, String id) async {
    return await ApiRequestBuilder<dynamic>(
            method: HttpMethod.MULTIPART,
            endPoint: "api/Deposit/manual",
            params: id,
            imageContent: imageFile,
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

  Future<EventResult<dynamic>> addBankCard(String paymentChannelId, BankType bankType,
      {String address, bankAccount, bankName, name, bankBranch}) async {
    return await ApiRequestBuilder<dynamic>(
            method: HttpMethod.POST,
            endPoint: "api/bankinfo",
            params: address != null
                ? {
                    "paymentchannelid": paymentChannelId,
                    "banktype": bankType.getJson,
                    "detail": {"address": address},
                  }
                : {
                    "paymentchannelid": paymentChannelId,
                    "banktype": bankType.getJson,
                    "detail": {
                      "bankAccount": bankAccount,
                      "bankName": bankName,
                      "name": name,
                      "bankBranch": bankBranch
                    },
                  },
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> deleteBankCard(String bankInfoId) async {
    return await ApiRequestBuilder<dynamic>(
            method: HttpMethod.DELETE, endPoint: "api/bankinfo/$bankInfoId", jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<DepositRedirect>> leePayDepositOrder(String amount, String paymentId, String promotionId) async {
    return await ApiRequestBuilder<DepositRedirect>(
            method: HttpMethod.PUT,
            endPoint: "api/deposit/crypto/leepay",
            params: {
              "amount": amount,
              "paymentid": paymentId,
              "promotionid": promotionId,
            },
            converter: (json) => DepositRedirect.fromJson(json),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<DepositRedirect>> primePayDepositOrder(String amount, String paymentId, String promotionId) async {
    return await ApiRequestBuilder<DepositRedirect>(
            method: HttpMethod.POST,
            endPoint: "api/deposit/bank/primepay",
            params: {
              "amount": amount,
              "paymentid": paymentId,
              "promotionid": promotionId,
            },
            converter: (json) => DepositRedirect.fromJson(json),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> withdraw(int amount, String bankInfoId, String payPassword) async {
    return await ApiRequestBuilder<dynamic>(
            method: HttpMethod.POST,
            endPoint: "api/withdraw",
            params: {
              "amount": amount.toString(),
              "bankinfoid": bankInfoId,
            },
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<DepositRedirectApplePay>> applePayDepositOrder(
      String amount, String paymentId, String promotionId, String transName) async {
    return await ApiRequestBuilder<DepositRedirectApplePay>(
            method: HttpMethod.POST,
            endPoint: "api/deposit/bank/applepay",
            params:  {
                    "amount": int.parse(amount),
                    "paymentid": paymentId,
                    "promotionid": promotionId,
                    "transname": transName
                  },
        converter: (json) => DepositRedirectApplePay.fromJson(json),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<ExchangeRate>> getLeePayExchangeRate(String paymentId) async {
    return await ApiRequestBuilder<ExchangeRate>(
            method: HttpMethod.GET,
            endPoint: "api/deposit/crypto/leepay/exchangerate",
            params: paymentId,
            converter: (json) => ExchangeRate.fromJson(json),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<DepositRedirect>> umPayBankDepositOrder(
      String amount, String paymentId, String promotionId) async {
    return await ApiRequestBuilder<DepositRedirect>(
            method: HttpMethod.POST,
            endPoint: "api/deposit/bank/umpay",
            params: {
              "amount": amount,
              "paymentid": paymentId,
              "promotionid": promotionId,
            },
            converter: (json) => DepositRedirect.fromJson(json),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<DepositRedirect>> umPayCryptoDepositOrder(
      String amount, String paymentId, String promotionId) async {
    return await ApiRequestBuilder<DepositRedirect>(
            method: HttpMethod.POST,
            endPoint: "api/deposit/crypto/umpay",
            params: {
              "amount": amount,
              "paymentid": paymentId,
              "promotionid": promotionId,
            },
            converter: (json) => DepositRedirect.fromJson(json),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<UmPayExchangeRate>> getUmPayExchangeRate(String paymentId) async {
    return await ApiRequestBuilder<UmPayExchangeRate>(
            method: HttpMethod.GET,
            endPoint: "api/deposit/crypto/umpay/exchangerate",
            params: paymentId,
            converter: (json) => UmPayExchangeRate.fromJson(json["rate"]["USDT"]["HKD"]),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<DepositRedirect>> maticPayDepositOrder(String amount, String paymentId, String promotionId) async {
    return await ApiRequestBuilder<DepositRedirect>(
        method: HttpMethod.POST,
        endPoint: "api/deposit/bank/maticpay",
        params: {
          "amount": amount,
          "paymentid": paymentId,
          "promotionid": promotionId,
        },
        converter: (json) => DepositRedirect.fromJson(json),
        jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<dynamic>> getTurnoverAmount() async {
    //will return int or double
    return await ApiRequestBuilder<dynamic>(
        method: HttpMethod.GET,
        endPoint: "api/withdraw/player/amount",
        jwtRefresher: jwtAuth)
        .execute();
  }
}

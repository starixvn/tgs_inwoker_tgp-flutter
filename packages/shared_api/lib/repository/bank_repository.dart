import 'dart:convert';
import 'dart:io';

import 'package:shared_api/entity/bank_card.dart';
import 'package:shared_api/entity/bank_type.dart';
import 'package:shared_api/entity/deposit_redirect.dart';
import 'package:shared_api/entity/deposit_redirect_applepay.dart';
import 'package:shared_api/entity/exchange_rate.dart';
import 'package:shared_api/entity/manual_deposit_order.dart';
import 'package:shared_api/entity/game_provider.dart';
import 'package:shared_api/entity/http_method.dart';
import 'package:shared_api/entity/payment.dart';
import 'package:shared_api/entity/user_profile.dart';
import 'package:shared_api/entity/withdrawal_info.dart';
import 'package:shared_api/network/api_request_builder.dart';
import 'package:shared_api/network/event_result.dart';

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

  Future<EventResult<String>> getManualDepositId(String account, String amount, String paymentId, String promotionId) async {
    return await ApiRequestBuilder<String>(
            method: HttpMethod.PUT,
            endPoint: "api/deposit/manual",
            params: promotionId!=null?{
              "account": account,
              "amount": amount,
              "paymentid": paymentId,
              "promotionid": promotionId,
            }:{
              "account": account,
              "amount": amount,
              "paymentid": paymentId,
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
                    "banktype": bankType.displayName,
                    "detail": {"address": address},
                  }
                : {
                    "paymentchannelid": paymentChannelId,
                    "banktype": bankType.displayName,
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
            params: promotionId!=null?{
              "amount": amount,
              "paymentid": paymentId,
              "promotionid": promotionId,
            }:{
              "amount": amount,
              "paymentid": paymentId,
            },
            converter: (json) => DepositRedirect.fromJson(json),
            jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<DepositRedirect>> primePayDepositOrder(String amount, String paymentId, String promotionId) async {
    return await ApiRequestBuilder<DepositRedirect>(
            method: HttpMethod.POST,
            endPoint: "api/deposit/bank/primepay",
            params: promotionId!=null?{
              "amount": amount,
              "paymentid": paymentId,
              "promotionid": promotionId,
            }:{
              "amount": amount,
              "paymentid": paymentId,
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
          "paypassword": payPassword,
        },
        jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<DepositRedirectApplePay>> applePayDepositOrder(String amount, String paymentId, String promotionId, String transName) async {
    return await ApiRequestBuilder<DepositRedirectApplePay>(
        method: HttpMethod.POST,
        endPoint: "api/deposit/bank/applepay",
        params: promotionId!=null?{
          "amount": int.parse(amount),
          "paymentid": paymentId,
          "promotionid": promotionId,
          "transname":transName
        }:{
          "amount": int.parse(amount),
          "paymentid": paymentId,
          "transname": transName
        },
        converter: (json) => DepositRedirectApplePay.fromJson(json),
        jwtRefresher: jwtAuth)
        .execute();
  }

  Future<EventResult<ExchangeRate>> getExchangeRate(String paymentId) async {
    return await ApiRequestBuilder<ExchangeRate>(
        method: HttpMethod.GET,
        endPoint: "api/deposit/crypto/leepay/exchangerate",
        params: paymentId,
        converter: (json) => ExchangeRate.fromJson(json),
        jwtRefresher: jwtAuth)
        .execute();
  }
}

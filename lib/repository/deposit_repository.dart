
import 'dart:convert';
import 'dart:io';

import 'package:tgp_flutter/entity/deposit_order.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/http_method.dart';
import 'package:tgp_flutter/entity/payment.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/network/api_request_builder.dart';
import 'package:tgp_flutter/network/event_result.dart';

import 'base_repository.dart';

class DepositRepository extends BaseRepository {
  static DepositRepository _singleton;
  UserProfile userProfile;
  List<GameProvider> gameProviderList;

  static DepositRepository getSingleton() {
    if (_singleton == null) {
      _singleton = DepositRepository();
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
}

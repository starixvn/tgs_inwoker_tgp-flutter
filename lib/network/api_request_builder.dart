import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/entity/http_method.dart';
import 'package:tgp_flutter/entity/response/BaseResponse.dart';
import 'package:tgp_flutter/entity/response/login_response.dart';
import 'package:tgp_flutter/network/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'event_result.dart';

typedef T ResponseResultConverter<T>(dynamic);
typedef Future JwtRefresher();
typedef void ResultConsumer(T);

class ApiRequestBuilder<T> extends ChangeNotifier {
  bool isAuthorization;
  bool isJWTAuthRequest;
  HttpMethod method;
  String? endPoint;
  dynamic params;
  ResponseResultConverter<T>? converter;
  int retryCounter = 0;
  JwtRefresher? jwtRefresher;
  ResultConsumer? consumer;
  dynamic imageContent;
  int timeout;
  bool isAssetUrl;
  bool isAutoHeader;

  ApiRequestBuilder(
      {this.isAuthorization = true,
      this.isJWTAuthRequest = false,
      this.method = HttpMethod.POST,
      this.endPoint,
      this.params,
      this.converter,
      this.jwtRefresher,
      this.consumer,
      this.imageContent,
      this.timeout = 3,
      this.isAssetUrl = false,
      this.isAutoHeader = true});

  Future<EventResult<T>> execute() async {
    var response = await api(method, endPoint,
        content: params, isAuthorization: isAuthorization, imageContent: imageContent, timeout: timeout,isAssetUrl:isAssetUrl,isAutoHeader:isAutoHeader);
    var result = resolveBaseResponse(response, converter, consumer);
    if (result.errorCode == 101 && retryCounter < 2 && !isJWTAuthRequest) {
      retryCounter++;
      await jwtRefresher!();
      return execute();
    }
    return result;
  }

  EventResult<T> resolveBaseResponse<T>(http.Response response,
      [ResponseResultConverter<T>? converter, void Function(T)? onSuccess]) {
    var value = json.decode(response.body);
    print(value);
    var baseResponse = BaseResponse.fromJson(value);
    if ((baseResponse.error == null ||
        (baseResponse.error == 0 && baseResponse.errorMsgId == null && (baseResponse.msg?.isEmpty ?? false)) ||
        (baseResponse.success == null &&
            baseResponse.error == 0 &&
            baseResponse.errorMsgId == null &&
            (baseResponse.msg?.isEmpty ?? false)) ||
        (baseResponse.success ?? false))) {
      var dataToConvert = baseResponse.data ?? value;
      var result = converter == null ? dataToConvert as T : converter(dataToConvert);
      if (onSuccess != null) onSuccess(result);
      if (response.statusCode == 503 || baseResponse.error == 403 || baseResponse.errorMsgId == "UnderMaintenance")
        return EventResult.maintenance(result: result);
      else
        return EventResult.success(result);
    } else {
      return EventResult.failure(baseResponse.error, baseResponse.msg, baseResponse.errorMsgId, response.statusCode);
    }
  }

  Future<EventResult<dynamic>> executeWithoutBaseResponse() async {
    var response = await api(method, endPoint,
        content: params, isAuthorization: isAuthorization, imageContent: imageContent, timeout: timeout,isAssetUrl:isAssetUrl,isAutoHeader:isAutoHeader);
    var result = resolveWithoutBaseResponse(response, converter, consumer);
    // if (retryCounter < 2 && !isJWTAuthRequest) {
    //   retryCounter++;
    //   await jwtRefresher!();
    //   return executeWithoutBaseResponse();
    // }
    return result;
  }

  EventResult<dynamic> resolveWithoutBaseResponse<T>(http.Response response,
      [ResponseResultConverter<T>? converter, void Function(T)? onSuccess]) {
    var value = response.body;
    // if (value != null) {
    return EventResult.success(value);
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/entity/response/login_response.dart';
import 'package:tgp_flutter/network/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'event_result.dart';

typedef T ResponseResultConverter<T>(dynamic);
typedef EventResult<T> ResponseResolver<T>(
    http.Response response, ResponseResultConverter<T> converter,
    [ResultConsumer consumer]);
typedef Future JwtRefresher();
typedef void ResultConsumer(T);

enum HttpMethod { POST, GET, DELETE, PATCH, PUT }

class ApiRequestBuilder<T> {
  bool isAuthorization;
  bool isJWTAuthRequest;
  HttpMethod method;
  String endPoint;
  dynamic params;
  ResponseResultConverter<T> converter;
  ResponseResolver<T> resolver;
  int retryCounter = 0;
  JwtRefresher jwtRefresher;
  ResultConsumer consumer;

  ApiRequestBuilder(
      {this.isAuthorization = true,
      this.isJWTAuthRequest = false,
      this.method = HttpMethod.POST,
      this.endPoint,
      this.params,
      this.converter,
      this.resolver,
      this.jwtRefresher,
      this.consumer});

  Future<EventResult<T>> execute() async {
    var response = await request(method, endPoint, params, isAuthorization);
    var result = resolver(response, converter,consumer);
    if (result.errorCode == 101 && retryCounter < 2 && !isJWTAuthRequest) {
      retryCounter++;
      await jwtRefresher();
      return execute();
    }
    return result;
  }

  Future request(HttpMethod method, String endPoint, dynamic params, bool isAuthorization) {
    switch (method) {
      case HttpMethod.POST:
        return apiPost(endPoint, params, isAuthorization);
      case HttpMethod.GET:
        return apiGet(endPoint, content: params, isAuthorization: isAuthorization);
      case HttpMethod.DELETE:
        return apiDelete(endPoint, params, isAuthorization);
      case HttpMethod.PATCH:
        return apiPatch(endPoint, params, isAuthorization);
      case HttpMethod.PUT:
        return apiPut(endPoint, params, isAuthorization);
      default:
        return apiPost(endPoint, params, isAuthorization);
    }
  }
}

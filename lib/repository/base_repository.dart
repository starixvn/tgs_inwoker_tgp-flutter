import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tgp_flutter/entity/response/BaseResponse.dart';
import 'package:tgp_flutter/entity/response/login_response.dart';
import 'package:tgp_flutter/network/event_result.dart';


typedef T ResponseResultConverter<T>(dynamic);

class BaseRepository extends ChangeNotifier{
  EventResult<T> resolveBaseResponse<T>(http.Response response,ResponseResultConverter<T> converter, [void Function(T) onSuccess]){
    var map = json.decode(response.body);
    print(map);
    var baseResponse = BaseResponse.fromJson(json.decode(response.body));
    if(baseResponse.code == 0){
      var result = converter(baseResponse.data);
      if(onSuccess != null)
        onSuccess(result);
      notifyListeners();
      return EventResult.success(result);
    }else{
      return EventResult.failure(baseResponse.code, baseResponse.msg);
    }
  }

  EventResult<T> resolveResponse<T>(http.Response response,ResponseResultConverter<T> converter, [void Function(T) onSuccess]){
    var map = json.decode(response.body);
    if(map["err"]==0){
      var result = converter(map);
      if(onSuccess != null)
        onSuccess(result);
      notifyListeners();
      return EventResult.success(result);
    } else{
      return EventResult.failure(map["err"],map["errmsg"]);
    }
  }

  EventResult<T> resolveOnlyDataResponse<T>(http.Response response,ResponseResultConverter<T> converter, [void Function(T) onSuccess]){
    var map = json.decode(response.body);
    var result = converter(map);
    if(onSuccess != null)
      onSuccess(result);
    notifyListeners();
    return EventResult.success(result);
  }

  EventResult<T> resolveReportRoundResponse<T>(http.Response response,ResponseResultConverter<T> converter, [void Function(T) onSuccess]){
    var map = json.decode(response.body);
    if(map["errors"].length==0){
      var result = converter(map);
      if(onSuccess != null)
        onSuccess(result);
      notifyListeners();
      return EventResult.success(result);
    } else{
      return EventResult.failure(map["errors"].length, map["message"]);
    }
  }
}
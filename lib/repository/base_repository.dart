import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/entity/response/BaseResponse.dart';
import 'package:tgp_flutter/entity/response/login_response.dart';
import 'package:tgp_flutter/network/api_request_builder.dart';
import 'package:tgp_flutter/network/event_result.dart';

typedef T ResponseResultConverter<T>(dynamic);

class BaseRepository extends ChangeNotifier {
  Future<EventResult<LoginResponse>> jwtAuth() async {
    var apiState = await ApiRequestBuilder<LoginResponse>(
        isAuthorization: false,
        isJWTAuthRequest: true,
        endPoint: "api/Auth/jwt",
        params: {"client": "I7nKiimrZQOqnJ6ryjUw74c0Hi64KC6Myunhob4cHh8VOUIuZh4p63czefxyyzbZ", "currency": "CNY"},
        converter: (json) => LoginResponse.fromJson(json)).execute();

    if (apiState.isSuccess) {
      var authToken = apiState.result.token;
      _savePreferences(authToken);
      print("Authorization:" + authToken);
    }
    return apiState;
  }

  _savePreferences(String authToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("auth_token", authToken);
  }

  setRepoValues(Function set){
    set();
    notifyListeners();
  }
}

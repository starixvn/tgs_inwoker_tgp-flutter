
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const _url = "https://dev.operator.tgsdev.gq/";
var _header = {
  "Content-Type": "application/json; charset=utf-8",
};

apiPost(final endPoint, final content) async{
  var header = await _injectTokenToHeader();
  print("Api->Post:${_url+endPoint}");
  print(header);
  http.Response response = await http.post(
    _url + endPoint,
    headers: header,
    body: jsonEncode(content),
  );
  log("Api<-Done:${response.statusCode} \n ${response.body}");
  return response;
  /*if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to post URL.');
  }*/
}

apiGet(final endPoint, [final content]) async{
  var uri = Uri.https("dev.operator.tgsdev.gq" , endPoint, content);
  print("Api->Get:${_url+endPoint}");
  var header = await _injectTokenToHeader();
  http.Response response = await http.get(
    uri,
    headers: header,
  );
  log("Api<-Done:${response.statusCode} \n ${response.body}");
  return response;
  /*if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to post URL.');
  }*/
}

apiDelete(final endPoint, final content) async{
  print("Api->Get:${_url+endPoint}");
  var header = await _injectTokenToHeader();
  http.Response response = await http.delete(
    _url + endPoint,
    headers: header,
  );
  log("Api<-Done:${response.statusCode} \n ${response.body}");
  return response;
  /*if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to post URL.');
  }*/
}

_injectTokenToHeader()async{
  var prefs = await SharedPreferences.getInstance();
  var authToken = prefs.getString("auth_token");
  if(authToken != null) {
    _header["Authorization"] = "Bearer "+authToken;
  }
  var token = prefs.getString("token");
  if(token != null) {
    _header["Token"] = token;
  }else{
    _header.remove("Token");
  }
  return _header;
}

apiPatch(final endPoint, final content) async{
  print("Api->Patch:${_url+endPoint}");
  var header = await _injectTokenToHeader();
  http.Response response = await http.patch(
    _url + endPoint,
    headers: header,
    body: jsonEncode(content),
  );
  log("Api<-Done:${response.statusCode} \n ${response.body}");
  return response;
}

apiPut(final endPoint, final content) async{
  print("Api->Put:${_url+endPoint}");
  var header = await _injectTokenToHeader();
  http.Response response = await http.put(
    _url + endPoint,
    headers: header,
    body: jsonEncode(content),
  );
  log("Api<-Done:${response.statusCode} \n ${response.body}");
  return response;
}


import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const _url = "https://dev.operator.tgsdev.gq/";


apiPost(final endPoint, final content, [isAuthorization = true]) async{
  var header = await _injectTokenToHeader(isAuthorization);
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

apiGet(final endPoint, {final content, isAuthorization = true}) async{
  var uri = Uri.https("dev.operator.tgsdev.gq" , endPoint, content);
  print("Api->Get:${_url+endPoint}");
  var header = await _injectTokenToHeader(isAuthorization);
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

apiDelete(final endPoint, final content, [isAuthorization = true]) async{
  print("Api->Get:${_url+endPoint}");
  var header = await _injectTokenToHeader(isAuthorization);
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

apiPatch(final endPoint, final content, [isAuthorization = true]) async{
  print("Api->Patch:${_url+endPoint}");
  print("Api->Post Body:${content}");

  var header = await _injectTokenToHeader(isAuthorization);
  http.Response response = await http.patch(
    _url + endPoint,
    headers: header,
    body: jsonEncode(content),
  );
  log("Api<-Done:${response.statusCode} \n ${response.body}");
  return response;
}

apiPut(final endPoint, final content, [isAuthorization = true]) async{
  print("Api->Put:${_url+endPoint}");
  var header = await _injectTokenToHeader(isAuthorization);
  http.Response response = await http.put(
    _url + endPoint,
    headers: header,
    body: jsonEncode(content),
  );
  log("Api<-Done:${response.statusCode} \n ${response.body}");
  return response;
}


_injectTokenToHeader(bool isAuthorization)async{
  var _header = {
    "Content-Type": "application/json; charset=utf-8",
  };
  var prefs = await SharedPreferences.getInstance();
  var authToken = prefs.getString("auth_token");
  var auth_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0ZTg2NzE5Zi0yNDNmLTQ2ZjYtYjAxMC01Yzc1OGI3Mjg1YWYiLCJqdGkiOiJjMjE1OWRlNS0wNWFiLTQzZTEtYWU2Yi00MTExZmYwYWFkYTQiLCJjdXJyIjoiQ05ZIiwibmJmIjoxNjE4NTU5ODgzLCJleHAiOjE2MTg1NjM0ODMsImlhdCI6MTYxODU1OTg4MywiaXNzIjoib3BlcmF0b3ItYXBpIn0.RxQJPt-YcVhwZ68_QEPlhyZhcNgvR-jftDLRbOBxGE8";
  if(authToken != null) {
    _header["Authorization"] = "Bearer "+ authToken;
  }

  if(isAuthorization){
    var _token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNGZZZVlCQjJhTnZlbXExWkpwank1RWlMWDNkQjBEZDJLNWRUa05PdVFYQmlLZXFIdFRXNXFXMW1HNFlPZGc3c2VKbnpEUVZmdHpDaWxpb3FnTFZPRTJIRFNvUDByblFXQTJkUzZQVVVBdmFFaFFMZHZDUU1ncnVBQlEySDVITWdmY09iMWJLenpld01jeWxKaUFqQnp2YWJSTnVPTFZEbXZ4V25DcXEwRlRVeTdZeENXUFIxS2JRSm5nak5IRTJuaDd4bFFRRWIxUmUydW1nZDZwWHl6Tm0iLCJqdGkiOiJlYWZhNDliMy01M2M1LTRjZWUtYTAyYi1mMTJjZjI5MjA1M2YiLCJuYmYiOjE2MTg1NjAwMTksImV4cCI6MTYxODYwMzIxOSwiaWF0IjoxNjE4NTYwMDE5LCJpc3MiOiJvcGVyYXRvci1hcGkifQ.Dl79XK0_ai8QlRZ6obORaEMaRXIm3qg6XXN7ikXekXs";
    var token = prefs.getString("token");
    if(token != null) {
      _header["Token"] = token;
    }
  }
  return _header;
}

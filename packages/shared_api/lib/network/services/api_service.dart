import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_api/entity/http_method.dart';

http.Client client;
const timeoutDuration = Duration(seconds: 3);

Future<http.Response> api(HttpMethod method, final endPoint,
    {final content, isAuthorization = true, imageContent, url}) async {
  if (client == null) {
    client = http.Client();
  }

  var header = await _getHeader(isAuthorization);
  var url = 'https://operator.tgsstg.gq/' + endPoint;

  var onTimeout = () {
    // CustomToast.show("Debug:Timeout -> $url");
    print("Debug:Timeout -> $url");
    return api(method, endPoint, content: content, isAuthorization: isAuthorization);
  };
  print("Api->${method.getName}:$url");
  print(content);
  http.Response response;
  switch (method) {
    case HttpMethod.POST:
      response = await client
          .post(
            url,
            headers: header,
            body: jsonEncode(content),
          )
          .timeout(timeoutDuration, onTimeout: onTimeout);
      break;
    case HttpMethod.GET:
      {
        var queryParams;
        if (content is String)
          queryParams = "/" + content;
        else
          queryParams = "?" + Uri(queryParameters: content).query;

        print("Api->Start ${method.getName}:$url");

        response = await client
            .get(
              url + queryParams,
              headers: header,
            )
            .timeout(timeoutDuration, onTimeout: onTimeout);
        ;
        print("Api->End ${method.getName}:$url");
      }
      break;
    case HttpMethod.DELETE:
      response = await client
          .delete(
            url,
            headers: header,
          )
          .timeout(timeoutDuration, onTimeout: onTimeout);
      ;
      break;
    case HttpMethod.PATCH:
      response = await client
          .patch(
            url,
            headers: header,
            body: jsonEncode(content),
          )
          .timeout(timeoutDuration, onTimeout: onTimeout);
      break;
    case HttpMethod.PUT:
      response = await client
          .put(
            url,
            headers: header,
            body: jsonEncode(content),
          )
          .timeout(timeoutDuration, onTimeout: onTimeout);
      break;

    case HttpMethod.MULTIPART:
      var request = http.MultipartRequest("POST", Uri.parse(url + "/" + content));
      header.forEach((k, v) {
        request.headers[k] = v;
      });
      request.files.add(await http.MultipartFile.fromPath('file', imageContent));
      var imageRes = await request.send();
      response = await http.Response.fromStream(imageRes).timeout(timeoutDuration, onTimeout: onTimeout);
      ;
      break;
    default:
      response = await client
          .post(
            url,
            headers: header,
            body: jsonEncode(content),
          )
          .timeout(timeoutDuration, onTimeout: onTimeout);
      break;
  }

  log("Api<-Done:${response.statusCode} \n ${response.body}");
  return response;
}

_getHeader(bool isAuthorization) async {
  Map<String, String> _header = {"Content-Type": "application/json; charset=utf-8", "Accept-Language": await getLanguage()};
  await _getAuthorizationToken(_header);
  if (isAuthorization) await _getToken(_header);
  return _header;
}

 getLanguage() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  var languageCode = _prefs.getString("LANGUAGE_CODE") ?? "en-US";
  return languageCode;
}

_getAuthorizationToken(Map<String, String> header) async {
  var prefs = await SharedPreferences.getInstance();
  String authToken = prefs.getString("auth_token");
  var auth_token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0ZTg2NzE5Zi0yNDNmLTQ2ZjYtYjAxMC01Yzc1OGI3Mjg1YWYiLCJqdGkiOiJjMjE1OWRlNS0wNWFiLTQzZTEtYWU2Yi00MTExZmYwYWFkYTQiLCJjdXJyIjoiQ05ZIiwibmJmIjoxNjE4NTU5ODgzLCJleHAiOjE2MTg1NjM0ODMsImlhdCI6MTYxODU1OTg4MywiaXNzIjoib3BlcmF0b3ItYXBpIn0.RxQJPt-YcVhwZ68_QEPlhyZhcNgvR-jftDLRbOBxGE8";
  if (authToken != null) {
    header["Authorization"] = "Bearer " + authToken;
  }
  print(authToken);
}

_getToken(Map<String, String> header) async {
  var prefs = await SharedPreferences.getInstance();
  var _token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNGZZZVlCQjJhTnZlbXExWkpwank1RWlMWDNkQjBEZDJLNWRUa05PdVFYQmlLZXFIdFRXNXFXMW1HNFlPZGc3c2VKbnpEUVZmdHpDaWxpb3FnTFZPRTJIRFNvUDByblFXQTJkUzZQVVVBdmFFaFFMZHZDUU1ncnVBQlEySDVITWdmY09iMWJLenpld01jeWxKaUFqQnp2YWJSTnVPTFZEbXZ4V25DcXEwRlRVeTdZeENXUFIxS2JRSm5nak5IRTJuaDd4bFFRRWIxUmUydW1nZDZwWHl6Tm0iLCJqdGkiOiJlYWZhNDliMy01M2M1LTRjZWUtYTAyYi1mMTJjZjI5MjA1M2YiLCJuYmYiOjE2MTg1NjAwMTksImV4cCI6MTYxODYwMzIxOSwiaWF0IjoxNjE4NTYwMDE5LCJpc3MiOiJvcGVyYXRvci1hcGkifQ.Dl79XK0_ai8QlRZ6obORaEMaRXIm3qg6XXN7ikXekXs";
  String token = prefs.getString("token");
  if (token != null) {
    header["Token"] = token;
  }
}

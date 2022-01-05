import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/http_method.dart';
import 'package:tgp_flutter/environment_config.dart';

http.Client? client;
//const timeoutDuration = Duration(seconds: 5);

Future<http.Response> api(HttpMethod method, final endPoint,
    {final content, isAuthorization = true, imageContent, timeout = 3, isAssetUrl = false,isAutoHeader = true}) async {
  if (client == null) {
    client = http.Client();
  }

  var header = isAutoHeader ? await _getHeader(isAuthorization) : Map<String, String>();
  var url = (isAssetUrl ? EnvironmentConfig.assetUrl : EnvironmentConfig.url) + endPoint;
  var timeoutDuration = Duration(seconds: timeout);

  var onTimeout = () {
    // CustomToast.show("Debug:Timeout -> $url");
    print("Debug:Timeout -> $url");
    return api(method, endPoint, content: content, isAuthorization: isAuthorization, timeout: timeout,isAssetUrl:isAssetUrl,isAutoHeader:isAutoHeader);
  };

  _handleError(var exception) {
    ProgressDialog.hide();
    CustomToast.show(exception.message);
    return null;
  }

  print("Api->${method.getName}:$url");
  print(content);
  http.Response response;
  switch (method) {
    case HttpMethod.POST:
      response = await client!
          .post(
        Uri.parse(url),
        headers: header,
        body: jsonEncode(content),
      )
          .timeout(timeoutDuration, onTimeout: onTimeout)
          .catchError((e) => _handleError(e));
      break;
    case HttpMethod.GET:
      {
        var queryParams;
        if (content is String)
          queryParams = "/" + content;
        else
          queryParams = "?" + Uri(queryParameters: content).query;

        print("Api->Start ${method.getName}:$url");

        response = await client!
            .get(
          Uri.parse(url + queryParams),
          headers: header,
        )
            .timeout(timeoutDuration, onTimeout: onTimeout)
            .catchError((e) => _handleError(e));
        print("Api->End ${method.getName}:$url");
      }
      break;
    case HttpMethod.DELETE:
      response = await client!
          .delete(
        Uri.parse(url),
        headers: header,
      )
          .timeout(timeoutDuration, onTimeout: onTimeout)
          .catchError((e) => _handleError(e));
      break;
    case HttpMethod.PATCH:
      response = await client!
          .patch(
        Uri.parse(url),
        headers: header,
        body: jsonEncode(content),
      )
          .timeout(timeoutDuration, onTimeout: onTimeout)
          .catchError((e) => _handleError(e));
      break;
    case HttpMethod.PUT:
      response = await client!
          .put(
        Uri.parse(url),
        headers: header,
        body: jsonEncode(content),
      )
          .timeout(timeoutDuration, onTimeout: onTimeout)
          .catchError((e) => _handleError(e));
      break;

    case HttpMethod.MULTIPART:
      var request = http.MultipartRequest("POST", Uri.parse(url + "/" + content));
      header.forEach((k, v) {
        request.headers[k] = v;
      });
      request.files.add(await http.MultipartFile.fromPath('file', imageContent));
      var imageRes = await request.send();
      response = await http.Response.fromStream(imageRes)
          .timeout(timeoutDuration, onTimeout: onTimeout)
          .catchError((e) => _handleError(e));
      break;
    default:
      response = await client!
          .post(
        Uri.parse(url),
        headers: header,
        body: jsonEncode(content),
      )
          .timeout(timeoutDuration, onTimeout: onTimeout)
          .catchError((e) => _handleError(e));
      break;
  }

  log("Api<-Done:${response.statusCode} \n ${response.body}");
  return response;
}

_getHeader(bool isAuthorization) async {
  Map<String, String> _header = {
    "Content-Type": "application/json; charset=utf-8",
    "Accept-Language": await getLanguage(),
  };
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
  String? authToken = prefs.getString("auth_token");
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
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNGZZZVlCQjJhTnZlbXExWkpwanlsMEF6NU1wUjV2TWplckp3V2NOQldRUzF0cDkwUjhtd09oS3h0R2U1dG5UMzZpdUdoUXFVc0lURFRyNnczNVFOOUVGZ1RlQVd4andJOWVGelhtU2Zxc2w1bUROdmJibmJSWEhnWFFsSElPbTNoNFlwR094RjdsRFVDdU12MDBsS1M5emE4RmFrNmxiUjlQNWYxZ290NzBQdG5ndnBKSWRKTENVNkUzdzZBNXpDeGtqbU5IdVVVb1pwa1g4M1dJUWluYiIsImp0aSI6ImQxZTlmZTMzLWQ0MDEtNDYxMC1iMGE0LWVlOTFmZThlOWJhMSIsIm5iZiI6MTY0MTE4NDc3MywiZXhwIjoxNjQxMjI3OTczLCJpYXQiOjE2NDExODQ3NzMsImlzcyI6Im9wZXJhdG9yLWFwaSJ9.ahB2HujIj8BwBqMYyR-AKpimBtjikNsuYW7lP-JPAcs";
  String? token = prefs.getString("token");
  if (token != null) {
    header["Token"] = token;
  }
}

Future<http.Response> readJsonFile(String url) async{
  http.Response response = await client!.get(
      Uri.parse(url)
  );
  return response;
}

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/entity/http_method.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

api(HttpMethod method, final endPoint, {final content, isAuthorization = true, imageContent}) async {
  var header = await _getHeader(isAuthorization);
  var url = DotEnv.env["url"] + endPoint;
  print("Api->${method.getName}:$url");
  print(content);
  http.Response response;
  switch (method) {
    case HttpMethod.POST:
      response = await http.post(
        url,
        headers: header,
        body: jsonEncode(content),
      );
      break;
    case HttpMethod.GET:
      {
        var queryParams;
        if (content is String)
          queryParams = "/" + content;
        else
          queryParams = "?" + Uri(queryParameters: content).query;

        response = await http.get(
          url + queryParams,
          headers: header,
        );
      }
      break;
    case HttpMethod.DELETE:
      response = await http.delete(
        url,
        headers: header,
      );
      break;
    case HttpMethod.PATCH:
      response = await http.patch(
        url,
        headers: header,
        body: jsonEncode(content),
      );
      break;
    case HttpMethod.PUT:
      response = await http.put(
        url,
        headers: header,
        body: jsonEncode(content),
      );
      break;

    case HttpMethod.MULTIPART:
      var request = http.MultipartRequest("POST", Uri.parse(url + "/" + content));
      header.forEach((k, v) {
        request.headers[k] = v;
      });
      request.files.add(await http.MultipartFile.fromPath('file', imageContent));
      var imageRes = await request.send();
      response = await http.Response.fromStream(imageRes);
      break;
    default:
      response = await http.post(
        url,
        headers: header,
        body: jsonEncode(content),
      );
      break;
  }
  log("Api<-Done:${response.statusCode} \n ${response.body}");
  return response;
}

_getHeader(bool isAuthorization) async {
  var _header = {
    "Content-Type": "application/json; charset=utf-8",
  };
  _getAuthorizationToken(_header);
  if (isAuthorization) _getToken(_header);
  return _header;
}

_getAuthorizationToken(Map<String, String> header) async {
  var prefs = await SharedPreferences.getInstance();
  var authToken = prefs.getString("auth_token");
  var auth_token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0ZTg2NzE5Zi0yNDNmLTQ2ZjYtYjAxMC01Yzc1OGI3Mjg1YWYiLCJqdGkiOiJjMjE1OWRlNS0wNWFiLTQzZTEtYWU2Yi00MTExZmYwYWFkYTQiLCJjdXJyIjoiQ05ZIiwibmJmIjoxNjE4NTU5ODgzLCJleHAiOjE2MTg1NjM0ODMsImlhdCI6MTYxODU1OTg4MywiaXNzIjoib3BlcmF0b3ItYXBpIn0.RxQJPt-YcVhwZ68_QEPlhyZhcNgvR-jftDLRbOBxGE8";
  if (authToken != null) {
    header["Authorization"] = "Bearer " + authToken;
  }
}

_getToken(Map<String, String> header) async {
  var prefs = await SharedPreferences.getInstance();
  var _token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNGZZZVlCQjJhTnZlbXExWkpwank1RWlMWDNkQjBEZDJLNWRUa05PdVFYQmlLZXFIdFRXNXFXMW1HNFlPZGc3c2VKbnpEUVZmdHpDaWxpb3FnTFZPRTJIRFNvUDByblFXQTJkUzZQVVVBdmFFaFFMZHZDUU1ncnVBQlEySDVITWdmY09iMWJLenpld01jeWxKaUFqQnp2YWJSTnVPTFZEbXZ4V25DcXEwRlRVeTdZeENXUFIxS2JRSm5nak5IRTJuaDd4bFFRRWIxUmUydW1nZDZwWHl6Tm0iLCJqdGkiOiJlYWZhNDliMy01M2M1LTRjZWUtYTAyYi1mMTJjZjI5MjA1M2YiLCJuYmYiOjE2MTg1NjAwMTksImV4cCI6MTYxODYwMzIxOSwiaWF0IjoxNjE4NTYwMDE5LCJpc3MiOiJvcGVyYXRvci1hcGkifQ.Dl79XK0_ai8QlRZ6obORaEMaRXIm3qg6XXN7ikXekXs";
  var token = prefs.getString("token");
  if (token != null) {
    header["Token"] = token;
  }
}

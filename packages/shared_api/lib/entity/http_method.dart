enum HttpMethod { POST, GET, DELETE, PATCH, PUT, MULTIPART }

extension HttpMethodExtension on HttpMethod {
  String get getName {
    return this.toString().split(".").last;
  }
}

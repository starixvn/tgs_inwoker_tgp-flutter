import 'package:json_annotation/json_annotation.dart';
part 'data_response.g.dart';

@JsonSerializable()

class DataResponse {
  DataResponse(this.data);

  dynamic data;

  factory DataResponse.fromJson(Map<String, dynamic> json) => _$DataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DataResponseToJson(this);
}
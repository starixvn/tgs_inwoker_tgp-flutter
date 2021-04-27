
import 'package:json_annotation/json_annotation.dart';
part 'BaseResponse.g.dart';

@JsonSerializable()

class BaseResponse {
  BaseResponse(this.error, this.data, this.msg);

  @JsonKey(name: 'err')
  int error;
  dynamic data;
  @JsonKey(name: 'errmsg')
  String msg;

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
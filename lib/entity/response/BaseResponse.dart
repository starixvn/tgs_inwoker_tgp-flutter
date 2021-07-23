
import 'package:json_annotation/json_annotation.dart';
part 'BaseResponse.g.dart';

@JsonSerializable()

class BaseResponse {
  BaseResponse(this.error, this.data, this.msg, this.errorMsgId);

  @JsonKey(name: 'err')
  int error;
  dynamic data;
  @JsonKey(name: 'errmsg')
  String msg;
  bool success;
  @JsonKey(name: 'errmsgid')
  String errorMsgId;

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
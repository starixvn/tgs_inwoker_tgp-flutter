
import 'package:json_annotation/json_annotation.dart';
part 'check_username_response.g.dart';

@JsonSerializable()

class CheckUsernameResponse {
  CheckUsernameResponse(this.code, this.msg, this.isExist);

  @JsonKey(name: 'err')
  int code;
  @JsonKey(name: 'errmsg')
  String msg;
  @JsonKey(name: 'isexist')
  bool isExist;

  factory CheckUsernameResponse.fromJson(Map<String, dynamic> json) => _$CheckUsernameResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CheckUsernameResponseToJson(this);
}

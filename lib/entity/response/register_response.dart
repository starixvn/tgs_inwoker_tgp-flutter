
import 'package:json_annotation/json_annotation.dart';
part 'register_response.g.dart';

@JsonSerializable()

class RegisterResponse {
  RegisterResponse(this.code, this.msg, this.uid, this.isNew);

  @JsonKey(name: 'err')
  int code;
  @JsonKey(name: 'errmsg')
  String msg;
  String uid;
  @JsonKey(name: 'isnew')
  bool isNew;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

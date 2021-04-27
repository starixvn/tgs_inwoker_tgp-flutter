import 'package:json_annotation/json_annotation.dart';
part 'edit_password_response.g.dart';

@JsonSerializable()

class EditPasswordResponse {
  EditPasswordResponse(this.playerCode, this.updateTime);


  @JsonKey(name: 'playercode')
  String playerCode;
  @JsonKey(name: 'updatetime')
  String updateTime;

  factory EditPasswordResponse.fromJson(Map<String, dynamic> json) => _$EditPasswordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EditPasswordResponseToJson(this);
}
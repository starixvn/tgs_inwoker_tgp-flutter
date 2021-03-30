import 'package:json_annotation/json_annotation.dart';
part 'params.g.dart';

@JsonSerializable()

class Params {
  Params();

  String cid;
  String oid;

  factory Params.fromJson(Map<String, dynamic> json) => _$ParamsFromJson(json);
  Map<String, dynamic> toJson() => _$ParamsToJson(this);
}
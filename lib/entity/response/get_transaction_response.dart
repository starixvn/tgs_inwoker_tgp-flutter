import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/entity/bet_transaction.dart';
part 'get_transaction_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)

class GetTransactionResponse<T> {
  GetTransactionResponse(this.errors, this.msg, this.valid, this.totalCount, this.items);

  List<String> errors;
  bool valid;
  @JsonKey(name: 'message')
  String msg;
  int totalCount;
  List<T> items;


  /*factory GetTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetTransactionResponseToJson(this);*/

  factory GetTransactionResponse.fromJson(Map<String, dynamic> json, T Function(Object json) fromJsonT,) => _$GetTransactionResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$GetTransactionResponseToJson(this, toJsonT);
}
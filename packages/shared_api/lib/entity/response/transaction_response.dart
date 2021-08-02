import 'package:json_annotation/json_annotation.dart';
part 'transaction_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)

class TransactionResponse<T> {
  TransactionResponse(this.totalCount, this.items);

  int totalCount;
  List<T> items;

  factory TransactionResponse.fromJson(Map<String, dynamic> json, T Function(Object json) fromJsonT,) => _$TransactionResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$TransactionResponseToJson(this, toJsonT);
}
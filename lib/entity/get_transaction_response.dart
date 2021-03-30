
import 'package:json_annotation/json_annotation.dart';
part 'get_transaction_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)

class GetTransactionResponse<T> {
  GetTransactionResponse(this.total, this.pageSize, this.transactions);

  int total;
  @JsonKey(name: "page_size")
  int pageSize;
  @JsonKey(name: "datas")
  List<T> transactions;

  /*factory GetTransactionResponse.fromJson(Map<String, dynamic> json) => _$GetTransactionResponseFromJson<T>(json);
  Map<String, dynamic> toJson() => _$GetTransactionResponseToJson(this);*/

  factory GetTransactionResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object json) fromJsonT,
      ) =>
      _$GetTransactionResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$GetTransactionResponseToJson(this, toJsonT);
}

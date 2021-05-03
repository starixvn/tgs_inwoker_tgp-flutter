import 'package:json_annotation/json_annotation.dart';
part 'transfer_limit.g.dart';

@JsonSerializable()

class TransferLimit {
  TransferLimit();

  double from;
  double to;

  factory TransferLimit.fromJson(Map<String, dynamic> json) => _$TransferLimitFromJson(json);
  Map<String, dynamic> toJson() => _$TransferLimitToJson(this);
}
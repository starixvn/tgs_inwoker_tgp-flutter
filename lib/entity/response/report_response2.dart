import 'package:json_annotation/json_annotation.dart';

part 'report_response2.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ReportResponse2<T> {
  ReportResponse2(this.totalCount, this.items);

  @JsonKey(name: 'totalcount')
  int totalCount;
  List<T>? items;

  factory ReportResponse2.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ReportResponse2FromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$ReportResponse2ToJson(this, toJsonT);
}
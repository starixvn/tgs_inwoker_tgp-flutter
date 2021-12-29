import 'package:json_annotation/json_annotation.dart';

part 'report_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ReportResponse<T> {
  ReportResponse(this.totalCount, this.items);

  int? totalCount;
  List<T>? items;

  factory ReportResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ReportResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$ReportResponseToJson(this, toJsonT);
}

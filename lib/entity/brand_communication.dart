import 'package:json_annotation/json_annotation.dart';

part 'brand_communication.g.dart';

@JsonSerializable()
class BrandCommunication {
  BrandCommunication(this.type, this.phone, this.appId, this.qrCodeUrl);

  String type;
  String phone;
  @JsonKey(name: 'appid')
  String? appId;
  @JsonKey(name: 'qrcodeurl')
  String? qrCodeUrl;

  factory BrandCommunication.fromJson(Map<String, dynamic> json) => _$BrandCommunicationFromJson(json);

  Map<String, dynamic> toJson() => _$BrandCommunicationToJson(this);
}

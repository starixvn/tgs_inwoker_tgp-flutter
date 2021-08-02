import 'package:shared_api/entity/deposit_order_transfer_bank.dart';
import 'package:shared_api/entity/params.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

@JsonSerializable()

class Order {

  int id;
  @JsonKey(name: "payment_id")
  int paymentId;
  @JsonKey(name: "payment_type_id")
  int paymentTypeId;
  @JsonKey(name: "type_class")
  String typeClass;
  @JsonKey(name: "type_title")
  String typeTitle;
  String sn;
  String amount;
  @JsonKey(name: "is_qrcode")
  int isQrcode;
  @JsonKey(name: "is_transfer")
  int isTransfer;
  String url;
  String qrcode;
  dynamic content;
  @JsonKey(name: "expired_time")
  int expiredTime;
  @JsonKey(name: 'order_time')
  String orderTime;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Params params;

  Order(
  int id,
  int paymentId,
  int paymentTypeId,
  String typeClass,
  String typeTitle,
  String sn,
  String amount,
  int isQrcode,
  int isTransfer,
  String url,
  String qrcode,
  dynamic content,
  int expiredTime,
  String orderTime
      ){
    this.id = id;
    this.paymentId = paymentId;
    this.paymentTypeId = paymentTypeId;
    this.typeClass = typeClass;
    this.typeTitle = typeTitle;
    this.sn = sn;
    this.amount = amount;
    this.isQrcode = isQrcode;
    this.isTransfer = isTransfer;
    this.url = url;
    this.qrcode = qrcode;
    this.content = content;
    this.expiredTime = expiredTime;
    this.orderTime = orderTime;
  }

/*  Order.convertByDepositResponseAndPayment(DepositResponse depositResponse, Payment payment){
    this.id = depositResponse.order.id;
    this.paymentId = depositResponse.paymentId;
    this.paymentTypeId = 0;
   *//* this.typeClass = payment.typeClass;
    this.typeTitle = payment.typeTitle;*//*
    this.sn = depositResponse.order.sn;
    this.amount = depositResponse.order.amount;
    this.isQrcode = depositResponse.isQrcode;
    this.isTransfer = depositResponse.isTransfer;
    this.url = depositResponse.url as String ?? "";
    this.qrcode = depositResponse.qrcode;
    this.content = depositResponse.url;
    this.expiredTime = depositResponse.expiredTime;
    this.orderTime = depositResponse.order.orderTime;
    this.params = depositResponse.params;
  }*/

  DepositOrderTransferBank getDepositOrderTransferBank(){
    if(content !=null) return DepositOrderTransferBank.fromJson(content as Map<String, dynamic>);
    else return null;
  }

  String getFormData(){
    if(params !=null) return "oid=${params.oid}&cid=${params.cid}";
    else return null;
  }
}

import 'package:shared_api/entity/message.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_message_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)

class GetMessageListResponse{
  GetMessageListResponse(this.totalCount, this.pageSize, this.messageList);

  @JsonKey(name: "total")
  int totalCount;
  @JsonKey(name: "page_size")
  int pageSize;
  @JsonKey(name: "datas")
  List<Message> messageList;

  factory GetMessageListResponse.fromJson(Map<String, dynamic> json) => _$GetMessageListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetMessageListResponseToJson(this);
}

import 'package:dineseater_client_gilson/model/waiting_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'waiting_list_response.g.dart';

@JsonSerializable()
class WaitingListResponse {
  late String message;
  late List<WaitingItem> waitings;

  WaitingListResponse();

  factory WaitingListResponse.fromJson(Map<String, dynamic> json) =>
      _$WaitingListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WaitingListResponseToJson(this);
}

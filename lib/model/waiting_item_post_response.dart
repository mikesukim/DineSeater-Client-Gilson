// waiting_item_post_response.dart
import 'package:dineseater_client_gilson/model/waiting_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'waiting_item_post_response.g.dart';

@JsonSerializable()
class WaitingItemPostResponse {
  late String message;
  late WaitingItem waiting;

  WaitingItemPostResponse();

  factory WaitingItemPostResponse.fromJson(Map<String, dynamic> json) =>
      _$WaitingItemPostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WaitingItemPostResponseToJson(this);
}

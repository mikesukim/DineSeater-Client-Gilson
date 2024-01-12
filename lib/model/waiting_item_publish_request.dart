import 'package:dineseater_client_gilson/model/waiting_item.dart';
import 'package:json_annotation/json_annotation.dart';

import 'action_type.dart';

part 'waiting_item_publish_request.g.dart';

@JsonSerializable()
class WaitingItemPublishRequest {
  @JsonKey(name: 'action')
  ActionType action = ActionType.PUBLISH;

  @JsonKey(name: 'waiting')
  late WaitingItem waiting;

  WaitingItemPublishRequest();

  factory WaitingItemPublishRequest.fromJson(Map<String, dynamic> json) =>
      _$WaitingItemPublishRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WaitingItemPublishRequestToJson(this);
}

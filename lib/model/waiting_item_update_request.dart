import 'package:json_annotation/json_annotation.dart';

import 'action_type.dart';

part 'waiting_item_update_request.g.dart';

@JsonSerializable()
class WaitingItemUpdateRequest {
  @JsonKey(name: 'action')
  late ActionType action;

  @JsonKey(name: 'waiting_id')
  late String waitingId;

  WaitingItemUpdateRequest();

  factory WaitingItemUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$WaitingItemUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WaitingItemUpdateRequestToJson(this);
}

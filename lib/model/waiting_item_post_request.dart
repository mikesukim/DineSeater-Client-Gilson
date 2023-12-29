import 'package:dineseater_client_gilson/model/waiting_item.dart';
import 'package:json_annotation/json_annotation.dart';

import 'action_enum.dart';

part 'waiting_item_post_request.g.dart';

@JsonSerializable()
class WaitingItemPostRequest {
  @JsonKey(name: 'action')
  late ActionType action;

  @JsonKey(name: 'number_of_customers')
  late int numberOfCustomers;

  @JsonKey(name: 'detail_attribute')
  late DetailAttribute detailAttribute;

  @JsonKey(name: 'phone_number')
  late String phoneNumber;

  WaitingItemPostRequest({
    required this.action,
    required this.numberOfCustomers,
    required this.detailAttribute,
    required this.phoneNumber,
  });

  factory WaitingItemPostRequest.fromJson(Map<String, dynamic> json) =>
      _$WaitingItemPostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WaitingItemPostRequestToJson(this);
}

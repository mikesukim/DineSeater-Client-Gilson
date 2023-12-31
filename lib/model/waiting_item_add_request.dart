import 'package:dineseater_client_gilson/model/waiting_item.dart';
import 'package:json_annotation/json_annotation.dart';

import 'action_type.dart';

part 'waiting_item_add_request.g.dart';

@JsonSerializable()
class WaitingItemAddRequest {
  @JsonKey(name: 'action')
  late ActionType action;

  @JsonKey(name: 'name')
  late String name;

  @JsonKey(name: 'number_of_customers')
  late int numberOfCustomers;

  @JsonKey(name: 'detail_attribute')
  late DetailAttribute detailAttribute;

  @JsonKey(name: 'phone_number')
  late String phoneNumber;

  WaitingItemAddRequest({
    required this.numberOfCustomers,
    required this.detailAttribute,
    required this.phoneNumber,
    required this.name,
  }) : action = ActionType.ADD;

  factory WaitingItemAddRequest.fromJson(Map<String, dynamic> json) =>
      _$WaitingItemAddRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WaitingItemAddRequestToJson(this);
}

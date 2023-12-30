import 'package:json_annotation/json_annotation.dart';

part 'waiting_item.g.dart';

@JsonSerializable()
class WaitingItem {
  @JsonKey(name: 'business_name')
  late String businessName;

  @JsonKey(name: 'waiting_id')
  late String waitingId;

  @JsonKey(name: 'detail_attribute')
  late DetailAttribute detailAttribute;

  @JsonKey(name: 'status')
  late String status;

  @JsonKey(name: 'phone_number')
  late String phoneNumber;

  @JsonKey(name: 'number_of_customers')
  late int numberOfCustomers;

  @JsonKey(name: 'date_created')
  late String dateCreated;

  WaitingItem();

  factory WaitingItem.fromJson(Map<String, dynamic> json) =>
      _$WaitingItemFromJson(json);

  Map<String, dynamic> toJson() => _$WaitingItemToJson(this);
}

@JsonSerializable()
class DetailAttribute {
  @JsonKey(name: 'is_grill')
  late bool isGrill;

  @JsonKey(name: 'is_meal')
  late bool isMeal;

  DetailAttribute({
    required this.isMeal,
    required this.isGrill,
  });

  factory DetailAttribute.fromJson(Map<String, dynamic> json) =>
      _$DetailAttributeFromJson(json);

  Map<String, dynamic> toJson() => _$DetailAttributeToJson(this);
}
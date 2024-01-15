// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waiting_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaitingItem _$WaitingItemFromJson(Map<String, dynamic> json) => WaitingItem()
  ..businessName = json['business_name'] as String
  ..name = json['name'] as String
  ..waitingId = json['waiting_id'] as String
  ..detailAttribute =
      DetailAttribute.fromJson(json['detail_attribute'] as Map<String, dynamic>)
  ..status = json['status'] as String
  ..phoneNumber = json['phone_number'] as String
  ..numberOfCustomers = json['number_of_customers'] as int
  ..dateCreated = json['date_created'] as String
  ..lastModified = json['last_modified'] as String
  ..dateTextSent = json['date_text_sent'] as String?;

Map<String, dynamic> _$WaitingItemToJson(WaitingItem instance) =>
    <String, dynamic>{
      'business_name': instance.businessName,
      'name': instance.name,
      'waiting_id': instance.waitingId,
      'detail_attribute': instance.detailAttribute,
      'status': instance.status,
      'phone_number': instance.phoneNumber,
      'number_of_customers': instance.numberOfCustomers,
      'date_created': instance.dateCreated,
      'last_modified': instance.lastModified,
      'date_text_sent': instance.dateTextSent,
    };

DetailAttribute _$DetailAttributeFromJson(Map<String, dynamic> json) =>
    DetailAttribute(
      isMeal: json['is_meal'] as bool,
      isGrill: json['is_grill'] as bool,
    );

Map<String, dynamic> _$DetailAttributeToJson(DetailAttribute instance) =>
    <String, dynamic>{
      'is_grill': instance.isGrill,
      'is_meal': instance.isMeal,
    };

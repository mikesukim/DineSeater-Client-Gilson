// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waiting_item_add_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaitingItemAddRequest _$WaitingItemAddRequestFromJson(
        Map<String, dynamic> json) =>
    WaitingItemAddRequest(
      action: $enumDecode(_$ActionTypeEnumMap, json['action']),
      numberOfCustomers: json['number_of_customers'] as int,
      detailAttribute: DetailAttribute.fromJson(
          json['detail_attribute'] as Map<String, dynamic>),
      phoneNumber: json['phone_number'] as String,
    );

Map<String, dynamic> _$WaitingItemAddRequestToJson(
        WaitingItemAddRequest instance) =>
    <String, dynamic>{
      'action': _$ActionTypeEnumMap[instance.action]!,
      'number_of_customers': instance.numberOfCustomers,
      'detail_attribute': instance.detailAttribute,
      'phone_number': instance.phoneNumber,
    };

const _$ActionTypeEnumMap = {
  ActionType.ADD: 'add',
  ActionType.REPORT_MISSED: 'report_missed',
  ActionType.REPORT_ARRIVAL: 'report_arrival',
};

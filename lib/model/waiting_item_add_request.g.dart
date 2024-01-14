// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waiting_item_add_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaitingItemAddRequest _$WaitingItemAddRequestFromJson(
        Map<String, dynamic> json) =>
    WaitingItemAddRequest(
      numberOfCustomers: json['number_of_customers'] as int,
      detailAttribute: DetailAttribute.fromJson(
          json['detail_attribute'] as Map<String, dynamic>),
      phoneNumber: json['phone_number'] as String,
      name: json['name'] as String,
    )..action = $enumDecode(_$ActionTypeEnumMap, json['action']);

Map<String, dynamic> _$WaitingItemAddRequestToJson(
        WaitingItemAddRequest instance) =>
    <String, dynamic>{
      'action': _$ActionTypeEnumMap[instance.action]!,
      'name': instance.name,
      'number_of_customers': instance.numberOfCustomers,
      'detail_attribute': instance.detailAttribute,
      'phone_number': instance.phoneNumber,
    };

const _$ActionTypeEnumMap = {
  ActionType.ADD: 'add',
  ActionType.NOTIFY: 'notify',
  ActionType.REPORT_MISSED: 'report_missed',
  ActionType.REPORT_ARRIVAL: 'report_arrival',
  ActionType.REPORT_BACK_INITIAL_STATUS: 'report_back_initial_status',
  ActionType.PUBLISH: 'publish',
};

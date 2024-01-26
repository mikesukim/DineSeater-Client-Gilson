// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waiting_item_publish_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaitingItemPublishRequest _$WaitingItemPublishRequestFromJson(
        Map<String, dynamic> json) =>
    WaitingItemPublishRequest()
      ..action = $enumDecode(_$ActionTypeEnumMap, json['action'])
      ..waiting = WaitingItem.fromJson(json['waiting'] as Map<String, dynamic>);

Map<String, dynamic> _$WaitingItemPublishRequestToJson(
        WaitingItemPublishRequest instance) =>
    <String, dynamic>{
      'action': _$ActionTypeEnumMap[instance.action]!,
      'waiting': instance.waiting,
    };

const _$ActionTypeEnumMap = {
  ActionType.ADD: 'add',
  ActionType.NOTIFY: 'notify',
  ActionType.REPORT_MISSED: 'report_missed',
  ActionType.REPORT_ARRIVAL: 'report_arrival',
  ActionType.REPORT_CANCELLED: 'report_cancelled',
  ActionType.REPORT_BACK_INITIAL_STATUS: 'report_back_initial_status',
  ActionType.PUBLISH: 'publish',
};

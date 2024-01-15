// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waiting_item_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaitingItemUpdateRequest _$WaitingItemUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    WaitingItemUpdateRequest()
      ..action = $enumDecode(_$ActionTypeEnumMap, json['action'])
      ..waitingId = json['waiting_id'] as String;

Map<String, dynamic> _$WaitingItemUpdateRequestToJson(
        WaitingItemUpdateRequest instance) =>
    <String, dynamic>{
      'action': _$ActionTypeEnumMap[instance.action]!,
      'waiting_id': instance.waitingId,
    };

const _$ActionTypeEnumMap = {
  ActionType.ADD: 'add',
  ActionType.NOTIFY: 'notify',
  ActionType.REPORT_MISSED: 'report_missed',
  ActionType.REPORT_ARRIVAL: 'report_arrival',
  ActionType.REPORT_BACK_INITIAL_STATUS: 'report_back_initial_status',
  ActionType.PUBLISH: 'publish',
};

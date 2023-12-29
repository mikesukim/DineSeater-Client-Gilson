// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waiting_item_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaitingItemPostResponse _$WaitingItemPostResponseFromJson(
        Map<String, dynamic> json) =>
    WaitingItemPostResponse()
      ..message = json['message'] as String
      ..waiting = WaitingItem.fromJson(json['waiting'] as Map<String, dynamic>);

Map<String, dynamic> _$WaitingItemPostResponseToJson(
        WaitingItemPostResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'waiting': instance.waiting,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waiting_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaitingListResponse _$WaitingListResponseFromJson(Map<String, dynamic> json) =>
    WaitingListResponse()
      ..message = json['message'] as String
      ..waitings = (json['waitings'] as List<dynamic>)
          .map((e) => WaitingItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$WaitingListResponseToJson(
        WaitingListResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'waitings': instance.waitings,
    };

import 'package:json_annotation/json_annotation.dart';

enum WaitingStatus {
  @JsonValue("waiting")
  WAITING,
  @JsonValue("text_sent")
  TEXT_SENT,
  @JsonValue("arrived")
  ARRIVED,
  @JsonValue("missed")
  MISSED,
}

import 'package:json_annotation/json_annotation.dart';

enum ActionType {
  @JsonValue("add")
  ADD,
  @JsonValue("notify")
  NOTIFY,
  @JsonValue("report_missed")
  REPORT_MISSED,
  @JsonValue("report_arrival")
  REPORT_ARRIVAL,
  @JsonValue("report_cancelled")
  REPORT_CANCELLED,
  @JsonValue("report_back_initial_status")
  REPORT_BACK_INITIAL_STATUS,
  @JsonValue("publish")
  PUBLISH,
}

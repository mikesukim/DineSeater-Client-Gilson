import 'package:json_annotation/json_annotation.dart';

enum ActionType {
  @JsonValue("add") ADD,
  @JsonValue("report_missed") REPORT_MISSED,
  @JsonValue("report_arrival") REPORT_ARRIVAL,
}
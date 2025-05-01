import 'package:json_annotation/json_annotation.dart';

part 'assignment_settings_create_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AssignmentSettingsCreateRequest {
  final bool isRepeatingTheEntireCycle;
  final int turnDurationInDays;
  final DateTime startDateAndTime;
  final int groupSize;

  AssignmentSettingsCreateRequest({
    required this.isRepeatingTheEntireCycle,
    required this.turnDurationInDays,
    required this.startDateAndTime,
    required this.groupSize,
  });

  factory AssignmentSettingsCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$AssignmentSettingsCreateRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AssignmentSettingsCreateRequestToJson(this);
}

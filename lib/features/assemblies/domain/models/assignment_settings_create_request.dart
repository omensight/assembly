import 'package:json_annotation/json_annotation.dart';

part 'assignment_settings_create_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AssignmentSettingsCreateRequest {
  final bool isRepeatingTheEntireCycle;
  final int turnDurationInDays;
  final DateTime startDateAndTime;
  final int groupSize;
  final bool createGroups;

  AssignmentSettingsCreateRequest({
    required this.isRepeatingTheEntireCycle,
    required this.turnDurationInDays,
    required this.startDateAndTime,
    required this.groupSize,
    required this.createGroups,
  });

  factory AssignmentSettingsCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$AssignmentSettingsCreateRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AssignmentSettingsCreateRequestToJson(this);
}

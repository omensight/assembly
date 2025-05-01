import 'package:json_annotation/json_annotation.dart';

part 'assignment_settings.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AssignmentSettings {
  final String assignmentId;
  final DateTime startDateAndTime;
  final bool isRepeatingTheEntireCycle;
  final int turnDurationInDays;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int groupSize;

  AssignmentSettings({
    required this.assignmentId,
    required this.startDateAndTime,
    required this.isRepeatingTheEntireCycle,
    required this.turnDurationInDays,
    required this.createdAt,
    required this.updatedAt,
    required this.groupSize,
  });

  factory AssignmentSettings.fromJson(Map<String, dynamic> json) =>
      _$AssignmentSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentSettingsToJson(this);
}

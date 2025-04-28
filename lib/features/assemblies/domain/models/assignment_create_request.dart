import 'package:json_annotation/json_annotation.dart';

part 'assignment_create_request.g.dart';

@JsonSerializable()
class AssignmentCreateRequest {
  final String name;
  final String description;
  @JsonKey(name: 'rotation_duration')
  final int rotationDuration;

  AssignmentCreateRequest({
    required this.name,
    required this.description,
    required this.rotationDuration,
  });

  factory AssignmentCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$AssignmentCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentCreateRequestToJson(this);
}

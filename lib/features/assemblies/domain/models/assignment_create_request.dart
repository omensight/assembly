import 'package:json_annotation/json_annotation.dart';

part 'assignment_create_request.g.dart';

@JsonSerializable()
class AssignmentCreateRequest {
  final String name;
  final String description;

  AssignmentCreateRequest({required this.name, required this.description});

  factory AssignmentCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$AssignmentCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentCreateRequestToJson(this);
}

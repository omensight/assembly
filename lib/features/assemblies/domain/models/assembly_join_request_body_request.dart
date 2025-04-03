import 'package:json_annotation/json_annotation.dart';
part 'assembly_join_request_body_request.g.dart';

@JsonSerializable()
class AssemblyJoinRequestBodyRequest {
  @JsonKey(name: 'join_code')
  final String joinCode;

  AssemblyJoinRequestBodyRequest({required this.joinCode});

  factory AssemblyJoinRequestBodyRequest.fromJson(Map<String, dynamic> json) =>
      _$AssemblyJoinRequestBodyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AssemblyJoinRequestBodyRequestToJson(this);
}

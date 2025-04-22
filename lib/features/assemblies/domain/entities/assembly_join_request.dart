import 'package:assembly/features/auth/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'assembly_join_request.g.dart';

@JsonSerializable()
class AssemblyJoinRequest {
  final String id;
  @JsonKey(name: 'assembly_id')
  final String assemblyId;
  final User user;

  AssemblyJoinRequest({
    required this.id,
    required this.user,
    required this.assemblyId,
  });

  factory AssemblyJoinRequest.fromJson(Map<String, dynamic> json) =>
      _$AssemblyJoinRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AssemblyJoinRequestToJson(this);
}

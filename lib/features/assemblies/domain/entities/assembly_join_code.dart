import 'package:json_annotation/json_annotation.dart';
part 'assembly_join_code.g.dart';

@JsonSerializable()
class AssemblyJoinCode {
  @JsonKey(name: 'assembly_id')
  final String assemblyId;

  @JsonKey(name: 'join_code')
  final String joinCode;

  AssemblyJoinCode({required this.assemblyId, required this.joinCode});

  factory AssemblyJoinCode.fromJson(Map<String, dynamic> json) =>
      _$AssemblyJoinCodeFromJson(json);

  Map<String, dynamic> toJson() => _$AssemblyJoinCodeToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
part 'assembly_create_request.g.dart';

@JsonSerializable()
class AssemblyCreateRequest {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'address')
  final String address;

  AssemblyCreateRequest({required this.name, required this.address});

  factory AssemblyCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$AssemblyCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AssemblyCreateRequestToJson(this);
}

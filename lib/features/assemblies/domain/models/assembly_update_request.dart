import 'package:json_annotation/json_annotation.dart';

part 'assembly_update_request.g.dart';

@JsonSerializable()
class AssemblyUpdateRequest {
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;

  @JsonKey(name: 'address', includeIfNull: false)
  final String? address;

  @JsonKey(name: 'is_active', includeIfNull: false)
  final bool? isActive;

  AssemblyUpdateRequest({this.name, this.address, this.isActive});

  factory AssemblyUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$AssemblyUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AssemblyUpdateRequestToJson(this);
}

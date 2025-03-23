import 'package:json_annotation/json_annotation.dart';
part 'server_token.g.dart';

@JsonSerializable()
class ServerToken {
  final DateTime expiry;
  final String token;

  ServerToken({
    required this.expiry,
    required this.token,
  });

  factory ServerToken.fromJson(Map<String, dynamic> json) =>
      _$ServerTokenFromJson(json);

  Map<String, dynamic> toJson() => _$ServerTokenToJson(this);
}

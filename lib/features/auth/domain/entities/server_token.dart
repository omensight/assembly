import 'package:assembly/core/data/database/assembly_database.dart';
import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart';
part 'server_token.g.dart';

const uniqueId = 1;

@JsonSerializable()
class ServerToken extends Insertable<ServerToken> {
  final DateTime expiry;
  final String token;

  ServerToken({required this.expiry, required this.token});

  factory ServerToken.fromJson(Map<String, dynamic> json) =>
      _$ServerTokenFromJson(json);

  Map<String, dynamic> toJson() => _$ServerTokenToJson(this);

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return ServerTokensCompanion(
      expiry: Value(expiry),
      token: Value(token),
      id: Value(uniqueId),
    ).toColumns(nullToAbsent);
  }
}

@UseRowClass(ServerToken)
class ServerTokens extends Table {
  IntColumn get id => integer()();
  DateTimeColumn get expiry => dateTime()();
  TextColumn get token => text()();
}
